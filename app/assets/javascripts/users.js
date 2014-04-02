$(document).on("ready", function(){
  $("#usuarios-li").addClass("active")
});

function getUserParticipations(userId, nombre, mail) {
		$.ajax({
    beforeSend: function( xhr ) {
      var token = $('meta[name="csrf-token"]').attr('content');
      if (token) xhr.setRequestHeader('X-CSRF-Token', token);
    }, 
    type: "GET",
    url: "/users/" + userId + "/get_participations",
    dataType: "json",
    success: function(data, textStatus, jqXHR) {
      var entries = [];
      for (var index = 0; index < data.length; index++) {
				entries.push(data[index]);
      }
      if (nombre)
        $("#myModal h2").text("Respuestas de " + nombre);
      else
        $("#myModal h2").text("Respuestas de " + mail);
      showModal(entries);
    },
    error: function() {
    } 
  });
}


function showModal(entries) {
	$("#userEntries").empty();
  
  if (entries.length > 0) {
    for (var index = 0; index < entries.length; index++) {
      var pregunta = entries[index].question.name;
      var respuesta = entries[index].answer;
      var codigo = entries[index].bottle.code;
      $("#userEntries").append('<tr><th>Pregunta</th><th>Respuesta</th><th>Código</th></tr>');
      $("#userEntries").append('<tr><td>' + pregunta + ' </td><td>' + respuesta + '</td><td>'+ codigo + '</td></tr>');
    }
  }
  else {

  }
  $("#myModal").modal({maxWidth:600, minHeight:450});
}