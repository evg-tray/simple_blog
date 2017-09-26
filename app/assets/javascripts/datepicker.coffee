datepicker = ->
  $('#datetimepicker').datetimepicker
    locale: 'ru'

$(document).on('turbolinks:load', datepicker)
