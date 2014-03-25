$(document).on("ready", onReady);

function onReady() {
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
  	 $("#main-section").fadeOut(function() {
        $(this).html(data).slideDown();
      });
    },
    error: function() {
    } 
  });
}