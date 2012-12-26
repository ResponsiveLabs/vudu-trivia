# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  interval = setInterval () ->
    remaining = parseInt $("#timer #seconds").text()
    remaining -= 1
    $("#timer #seconds").text(remaining)
    if remaining == 10
      $("#timer").addClass('red')
    else if remaining == 0
      clearInterval(interval)
      window.location.href = redirectUrl
  , 1000



