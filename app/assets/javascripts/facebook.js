$(document).on("ready", onReady);

function onReady() {
  if (isIECompatible()) {
    loadFB();  
  }
  else {
   // window.location = '/ie8.html';
  }
}

function isIECompatible() {
  var compatible = true;
  var browser = (function() {
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer') {
      var ua = navigator.userAgent;
      var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
      if (re.exec(ua) != null)
        rv = parseFloat( RegExp.$1 );
   }
   return rv;
  })();

  if (browser > -1) {
    if (browser < 9) {
      compatible = false;
    }
  }
  return compatible
}

function loadFB() {
  window.fbAsyncInit = function() {
    // init the FB JS SDK
    FB.init({
      appId      : '1398368863767276', // App ID from the App Dashboard
      status     : true, // check the login status upon init?
      cookie     : true, // set sessions cookies to allow your server to access the session?
      xfbml      : true  // parse XFBML tags on this page?
    });
  };

  // Load the SDK's source Asynchronously
  // Note that the debug version is being actively developed and might 
  // contain some type checks that are overly strict. 
  // Please report such bugs using the bugs tool.
  (function(d, debug){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/es_LA/all" + (debug ? "/debug" : "") + ".js";
     ref.parentNode.insertBefore(js, ref);
   }(document, /*debug*/ false));
}

function login() {
 FB.login(function(response) {
    if (response.authResponse) {
      $.ajax({
        type: "GET",
        url: "/users/auth/facebook/callback",
        success: function(data, textStatus, jqXHR) {
          console.log("success");
          $(document).trigger('participar', data);   
        },
        error: function() {
        } 
      });
    } else {
      // cancelled
    }
  }, {scope: 'email,publish_actions'});
  
}

function publishEntry() {
  FB.ui({
    method: 'feed',
    name: 'ACCESO TOTAL TRADICIONAL®', 
    description: 'Yo ya estoy participando en Acceso Total por un viaje todo pagado a Cannes, Francia. ¡Tú también atrévete a vivir una experiencia que el dinero no puede comprar!',
    link: 'http://accesototaltradicional.com',
    picture: 'http:/accesototaltradicional.com/assets/post_wall.jpg'
  });
}
