extends Node

signal settings_toggled()

var office_camera = null
var right_door_camera = null
var left_door_camera = null
var left_hallway_camera = null
var right_hallway_camera = null
var janitor_camera = null
var dining_room_camera = null
var bathroom_camera = null
var foxy_camera = null
var parts_room_camera = null
var stage_camera = null

var cameras_open = false
var current_camera = right_door_camera


var left_movement = false
var right_movement = false


var settings_open = false:
    set(new_value):
       if settings_open != new_value:
           settings_open = new_value
           emit_signal("settings_toggled")


var music_volume = 100
var candle_volume = 100
var office_lights = 100
