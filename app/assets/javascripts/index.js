var question;

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
    	$(".age-div").remove();
  	 	$("#marco").fadeIn(function() {
        $("#marco").html(data).slideDown();
      });
    },
    error: function() {
    } 
  });
}

function loginEmail() {

}

function onParticipar(event, values) {
	$("#marco").fadeIn(function() {
    $("#marco").html(values).slideDown();
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
			    	$("#marco").fadeIn(function() {
				    	$("#marco").html(data).slideDown();
				  	});
			    },
			    error: function() {
			    } 
			  });
    	}
    	else {
    		$(".error-txt").text("EL CÓDIGO NO ES VÁLIDO O YA FUE UTILIZADO EN ESTA PROMOCIÓN. INTENTA NUEVAMENTE CON UNO DIFERENTE.");
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
   	data: {"code": $("#ruby-values").data("code"), "question": question, "answer": $("#respuesta").val()},
   	data_type: "html",
   	success: function(data, textStatus, jqXHR) {
    	$("#marco").fadeIn(function() {
	    	$("#marco").html(data).slideDown();
	  	});
  },
  	error: function() {} 
  });
}

//E7D2296F