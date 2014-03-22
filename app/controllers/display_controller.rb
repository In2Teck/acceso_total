class DisplayController < ApplicationController
	
  #ROOT
  def index
    redirect_to :splash
  end

  #verificar edad
  def splash

  end
  
  
  def participar
	render :partial => 'participar', :content_type => 'json'
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
        end
        if (dia>=1) && (dia<=max)
                fecha=true
        end
	end
  
end
