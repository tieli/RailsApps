# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#jQuery ->
#    $("#movie_director").autocomplete
#        source: ['test01', 'test02', 'test03']
#$(document).ready ->
#  data = [
#    'Boston Celtics',
#    'Chicago Bulls',
#    'Miami Heat',
#    'Orlando Magic',
#    'Atlanta Hawks',
#    'Philadelphia Sixers',
#    'New York Knicks',
#    'Indiana Pacers',
#    'Charlotte Bobcats',
#    'Milwaukee Bucks',
#    'Detroit Pistons',
#    'New Jersey Nets',
#    'Toronto Raptors',
#    'Washington Wizards',
#    'Cleveland Cavaliers'
#  ]
#  $('#movie_director').autocomplete source: data
#  return

jQuery ->
  $('#movie_director').autocomplete
      source: $('#movie_director').data('autocomplete-source')

