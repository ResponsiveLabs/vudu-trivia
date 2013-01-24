// Facebook API methods

$(function() {

  $("#login").submit(function(e) {
    FB.login(function(response) {}, {scope: 'email,user_likes'});
    return false;
  });

});

