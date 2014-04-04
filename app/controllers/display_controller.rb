class DisplayController < ApplicationController
	
  #ROOT
  def index
    #redirect_to :splash
  end

  def registra_codigo

  end

  def tab
  	@signed_request = params[:signed_request]
    is_fan = (decode_data @signed_request)["page"]["liked"]
    if is_fan
    	render 'fan', :layout => 'tab'
    else
    	render 'no_fan', :layout => 'tab'
    end
  end

  def elige_pregunta
  	@code = params[:code]
  	@questions = Question.all()
  	render :partial => 'elige_pregunta', :content_type => 'text/html'
  end

  def registra_participacion
  	@participacion = Participation.new
  	@participacion.user_id = params[:user]
  	@participacion.bottle_id = params[:code]
  	@participacion.question_id = params[:question]
  	@participacion.answer = params[:answer]
  	@participacion.save
  	render :partial => 'registra_participacion', :content_type => 'text/html'
  end

  def invita_email
    emails = params[:emails]
    current_user_email = User.find(params[:current_user_email]).email
    emails.each do |email|
      UserMailer.registration_confirmation(email, current_user_email).deliver
    end    
  	render :partial => 'invita_email', :content_type => 'text/html'
  end
  
	def valida_edad
		day = params[:dia].to_i
		month = params[:mes].to_i
		year = params[:anio].to_i
		if es_menor(day, month, year)
			render :partial => 'menor_edad', :content_type => 'text/html'
		else 
			render :partial => 'participar', :content_type => 'text/html'
		end
	end
	
	def es_bisiesto(anio)
		return (anio % 4 == 0 && anio % 100 != 0)||(anio % 400 == 0)
	end #true si es bisiesto
	
	def es_menor(dia,mes,anio)
    fecha = false
  	if (mes >= 1) && (mes <= 12) then
			case mes
				when 1,3,5,7,8,10,12 then
					max = 31
				when 4,6,9,11 then
					max = 30
				when 2 then
					if (es_bisiesto(anio) == true) then
						max = 29
					else
						max = 28
			end
		end
		
		if (dia >= 1) && (dia <= max)
			birth = Date.civil(anio, mes, dia)
			now = Date.today
			difference_in_days = (now - birth).to_i
			diff = (difference_in_days / 365.25).to_i
			
			if diff < 17
				fecha = true
			end
		end
    else
			fecha = false
    end
    return fecha
	end

	def decode_data str
    encoded_sig, payload = str.split('.')
    data = ActiveSupport::JSON.decode base64_url_decode(payload)
  end

  def base64_url_decode str
    encoded_str = str.gsub('-','+').gsub('_','/')
    encoded_str += '=' while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end

end
