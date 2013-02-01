// Facebook API methods

$(function() {

  $("#login").submit(function(e) {
    FB.login(function(response) {
      if (response.authResponse) {
        // We want to reload the page now so Ruby can read the cookie that the
        // Javascript SDK sat. But we don't want to use
        // window.location.reload() because if this is in a canvas there was a
        // post made to this page and a reload will trigger a message to the
        // user asking if they want to send data again.
        window.location = window.location;
      }
    }, {scope: 'email,user_likes'});
    return false;
  });

  $("#invite").click(function(e) {
    e.preventDefault();
    FB.ui({
      method: 'apprequests',
      message: 'Juega la trivia Vudu'
    }, function(response) {
      // response = {request: "124417591066001", to: [504257371, 1000004486669060]}
    });
  });

});

