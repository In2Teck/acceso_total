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
      $("#mensaje_error_correo").text("CORREO INVÁLIDO");
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
  if ($("#respuesta").val().length > 0) {
    $.ajax({
      type: "GET",
      url: "/registra_participacion",
      data: {"code": $("#ruby-values").data("code"), "question": question, "answer": $("#respuesta").val(), "user": user},
      data_type: "html",
      success: function(data, textStatus, jqXHR) {
        $("#marco-div").fadeOut("slow", function() {
          $("#marco-div").html(data).fadeIn("slow", function(){
            if ($("#amigos_facebook").length > 0){
              publishEntry();
              var fql_query = "SELECT uid, name FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = " + $("#amigos_facebook").data("uid") + ") ORDER BY rand() limit 20"
              FB.api({
                  method: 'fql.query',
                  query: fql_query
              },
              function(response){
                  if (response[0]) {
                    $.each(response, function(index, value){
                      $("#amigos_facebook").append("<div class='img_wrapper'><img src='https://graph.facebook.com/"+ value.uid+"/picture?type=square' class='thumbnail' onload='imgLoaded(this)'/></div>");
                    });
                  } else {
                     $('<div id="dialog_1" title="Error"><p>La comunicación con Facebook no se pudo realizar.</p></div>').appendTo('body');    	
                      $("#dialog_1").dialog({
                            width: 300,
                            height: 150,
                            modal: true,
                            close: function(event, ui) {
                                $("#dialog_1").hide();
                            }
                      });
                  }
              }); 
            }
          });
        }); 
    },
      error: function() {} 
    });
  } else {
    $('<div id="dialog_2" title="Atención"><p>Favor de llenar el campo de respuesta.</p></div>').appendTo('body');    	
		$("#dialog_2").dialog({
            width: 300,
            height: 150,
            modal: true,
            close: function(event, ui) {
                $("#dialog_2").hide();
            }
    });
  }
}

function invitarAmigos() {
  FB.ui({
    method: 'apprequests', message: 'Tu amigo te acaba de invitar a ser parte de Acceso Total: Cannes. Aprovecha esta oportunidad y atrévete a vivir una experiencia que el dinero no puede comprar. Ingresa a nuestra página oficial y descubre cómo ganar: http://accesototaltradicional.com',
  }, function(response){console.log(response)});
}

function invitarAmigosEmail() {
  var email_list = $("#email_list").val().replace(/\s/g, '').split(",")
	var curerent_user_email = $("#user").data("id");   
    
  var bool = true;
  $.each(email_list, function(index, value){
    bool = bool && validateEmail(value);
  });

  if(bool){
    $.loader({className:"animated-loader", content:""});
    $.ajax({
        type: "GET",
        url: "/invita_email",
        data: {"emails": email_list, "current_user_email": curerent_user_email},
        data_type: "html",
        success: function(data, textStatus, jqXHR) {
        	$("#marco-div").fadeOut("slow", function() {
		        $("#marco-div").html(data).fadeIn("slow");
  		    });
        },
        error: function() {
          $('<div id="dialog_3" title="Error enviando correos"><p>Por favor vuelve a intentar más tarde.</p></div>').appendTo('body');    	
          $("#dialog_3").dialog({
                  width: 300,
                  height: 150,
                  modal: true,
                  close: function(event, ui) {
                      $("#dialog_3").hide();
                  }
          });
        },
        complete: function(){
          $("#jquery-loader-background").remove();
          $("#jquery-loader").remove(); 
        } 
      });
  }else{
    $('<div id="dialog_4" title="Atención"><p>Algún correo no fue escrito correctamente. Revísalos y vuelve a intentar.</p></div>').appendTo('body');	
		$("#dialog_4").dialog({
            width: 300,
            height: 150,
            modal: true,
            close: function(event, ui) {
                $("#dialog_4").hide();
            }
    });
  }
}
