# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('.user-cards-container').infiniteScroll
    path: ".next a"
    hideNav: '.pagination',
    append: ".user-card-frame"
    history: false
    prefill: true
    status: '.page-load-status'

$(document).on 'turbolinks:load', ->
  $('.post-cards').infiniteScroll
    path: "nav.pagination a[rel=next]"
    hideNav: '.pagination'
    append: ".post-card"
    history: false
    status: '.page-load-status'
    button: '.loadmore-btn'
    scrollThreshold: false