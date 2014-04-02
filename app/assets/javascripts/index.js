var question;
var user;

$(document).on("ready", onReady);

function onReady() {
	$(document).on("participar", onParticipar);
	$("#entrar-btn").on("click", onEntrar);
}

function onEntrar() {
	$.ajax({
    type: "GET",
    url: "/valida_edad",
    data: {"dia": $("#dia").val(), "mes": $("#mes").val(), "anio": $("#anio").val()},
    data_type: "html",
    success: function(data, textStatus, jqXHR) {
    	$(".age-div").fadeOut("slow", function() {
        $("#marco-div").html(data);
        $("#marco").fadeIn("slow");  
      });
    },
    error: function() {
    } 
  });
}

function loginEmail() {
	$.ajax({
    type: "GET",
    url: "/find_or_create_user",
    data: {"email": $("#email").val()},
    data_type: "html",
    success: function(data, textStatus, jqXHR) {
    	$("#marco-div").fadeOut("slow", function() {
		    $("#marco-div").html(data).fadeIn("slow");
		    user = $("#user").data("id");
		  });
    },
    error: function() {
    } 
  });
}

function onParticipar(event, values) {
	$("#marco-div").fadeOut("slow", function() {
    $("#marco-div").html(values).fadeIn("slow");
    user = $("#user").data("id");
  });
}

function validaCodigo() {
	$(".error-txt").text('');
	var code = $("#codigo").val().toUpperCase();
	 $.ajax({
    type: "GET",
    url: "/validate_bottle",
    data: {"code": code},
    success: function(data, textStatus, jqXHR) {
    	var result = data;
    	if (result) {
    		 $.ajax({
			    type: "GET",
			    url: "/elige_pregunta",
			    data: {"code": result.id},
			    data_type: "html",
			    success: function(data, textStatus, jqXHR) {
			    	$("#marco-div").fadeOut("slow", function() {
				    	$("#marco-div").html(data).fadeIn("slow");
              setTimeout(function() {
                cambiaPregunta(1);
              }, 50);
				  	});
            
			    },
			    error: function() {
			    } 
			  });
    	}
    	else {
    		$(".error-txt").html("EL CÓDIGO NO ES VÁLIDO O YA FUE UTILIZADO EN ESTA PROMOCIÓN.<br/> INTENTA NUEVAMENTE CON UNO DIFERENTE.");
    	}
    },
    error: function() {
    } 
  });
}

function cambiaPregunta(value) {
	$("#n1-btn").removeClass("down");
	$("#n2-btn").removeClass("down");
	$("#n3-btn").removeClass("down");
	switch (value) {
		case 1:
			$("#n1-btn").toggleClass("down");
			$(".pregunta").text($("#ruby-values").data("questions")[0].name);
			question = $("#ruby-values").data("questions")[0].id;
			break;
		case 2:
			$("#n2-btn").toggleClass("down");
			$(".pregunta").text($("#ruby-values").data("questions")[1].name);
			question = $("#ruby-values").data("questions")[1].id;
			break;
		case 3:
			$("#n3-btn").toggleClass("down");
			$(".pregunta").text($("#ruby-values").data("questions")[2].name);
			question = $("#ruby-values").data("questions")[2].id;
			break;
	}
}

function registraParticipacion() {
	$.ajax({
   	type: "GET",
   	url: "/registra_participacion",
   	data: {"code": $("#ruby-values").data("code"), "question": question, "answer": $("#respuesta").val(), "user": user},
   	data_type: "html",
   	success: function(data, textStatus, jqXHR) {
    	$("#marco-div").fadeOut("slow", function() {
	    	$("#marco-div").html(data).fadeIn("slow", function(){
          publishEntry();
        });
	  	});
  },
  	error: function() {} 
  });
}

function invitarAmigos() {
  FB.ui({
    method: 'apprequests', message: 'Participa en Acceso Total de Jose Cuervo Tradicional® para ganar un viaje todo pagado a Cannes, Francia',
  }, function(response){console.log(response)});
}
