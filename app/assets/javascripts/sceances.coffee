# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@loadCalendar = ->
  $('#calendar').fullCalendar {
    locale: 'fr',
    themeSystem: 'bootstrap3',
    defaultView: 'agendaWeek',
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'agendaWeek,agendaDay,listWeek'
    },
    allDaySlot: false,
    firstDay: 1, # Monday
    businessHours: {
      dow: [ 1, 2, 3, 4, 5, 6 ],
      start: '09:00',
      end: '19:00'
    }
    minTime: '08:00:00',
    maxTime: '20:00:00',
    events: {
      url: '/sceances.json'
    }
  }

@clearCalendar = ->
  $('#calendar').fullCalendar 'delete'
  # $('#event_calendar').html '';

$(document).on 'turbolinks:load', @loadCalendar
$(document).on('turbolinks:before-cache', @clearCalendar)
