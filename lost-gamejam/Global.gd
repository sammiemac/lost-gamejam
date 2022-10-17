extends Node


var lights_on = false
var speedrun = false

var level = 1

var checkpoint = 0
var player_start = Vector2(64, 32)
var scene_done = false

var deaths = 0

var time_started = false
var time_start = 0
var time_now = 0
var elapsed = 0
var minutes = 0
var seconds = 0
var str_elapsed = ""

func get_time():
	pass
