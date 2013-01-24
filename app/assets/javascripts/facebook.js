// Facebook API methods

$(function() {

  $("#login").click(function(e) {
    e.preventDefault();
    FB.login(function(response) {}, {scope: 'email,user_likes'});
  });

});

