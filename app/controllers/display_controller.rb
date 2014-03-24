class DisplayController < ApplicationController
	
  #ROOT
  def index
    redirect_to :splash
  end

  #verificar edad
  def splash

  end
  
  
  def participar
	respond_to do |format|
		format.json { render :partial => 'participar', :format=>"json" }
	end
  end

  def registra_codigo

  end

  def elige_pregunta

  end

  def invita_amigos

  end
  
	def valida_edad
		fecha = params[:id]
		
		render :partial => 'valida_edad', :content_type => 'json'
	end
	
	def es_bisiesto(anio)
		return (anio%4==0 && anio%100!=0)||(anio%400==0)
	end; #true si es bisiesto
	
	def fecha_correcta(dia,mes,anio)
        fecha=false
        if (mes>=1) && (mes<=12) then
			case mes
				when 1,3,5,7,8,10,12 then
						max=31
				when 4,6,9,11 then
						max=30
				when 2 then
					if (es_bisiesto(anio)==true) then
							max=29
					else
							max=28
					end
			end
			
			if (dia>=1) && (dia<=max)
				birth = Date.civil(anio, mes, dia)
				now = Date.today
				difference_in_days = (now - birth).to_i
				diff = (difference_in_days/365.25).to_i
				
				if diff < 17
					fecha=true
				end
			end
        else
			fecha = false
        end
	end
  
end
