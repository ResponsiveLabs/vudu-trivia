// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

// Facebook API methods
// TODO: move to fb.js

function logResponse(response) {
  if (console && console.log) {
    console.log('The response was', response);
  }
}

$(function(){
  // Set up so we handle click on the buttons
  $('#postToWall').click(function() {
    FB.ui(
      {
        method : 'feed',
        link   : $(this).attr('data-url')
      },
      function (response) {
        // If response is null the user canceled the dialog
        if (response != null) {
          logResponse(response);
        }
      }
    );
  });

  $('#sendToFriends').click(function() {
    FB.ui(
      {
        method : 'send',
        link   : $(this).attr('data-url')
      },
      function (response) {
        // If response is null the user canceled the dialog
        if (response != null) {
          logResponse(response);
        }
      }
    );
  });

  $('#sendRequest').click(function() {
    FB.ui(
      {
        method  : 'apprequests',
        message : $(this).attr('data-message')
      },
      function (response) {
        // If response is null the user canceled the dialog
        if (response != null) {
          logResponse(response);
        }
      }
    );
  });
});

