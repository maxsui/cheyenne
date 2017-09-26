$(document).on "turbolinks:load", ->
  $('#search_form button').on 'click', -> $('#search_form').submit()
