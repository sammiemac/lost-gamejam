extends Node2D


onready var global = get_node("/root/Global")


const FOLLOW_SPEED = 4.0
var lantern_pos = Vector2(-2, 0)

var level_complete = false
var use_light = -1 # -1 = reset


func _ready():
	global.level = 2
	$AnimationPlayer.play("fade in")
	$AnimationPlayer.play("tut fade in")
	
	if global.lights_on or global.speedrun:
		$Shadow.visible = false
	if global.speedrun:
		$AnimationPlayer.play("tut off")


func _process(_delta):
	if Input.is_action_just_pressed("restart"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/Level2.tscn")


func _physics_process(delta):
	
	var player_pos = $Player.global_position
	var mouse_pos = get_global_mouse_position()
	
	# If holding left-click, lantern follows mouse. Else, follows player
	if Input.is_mouse_button_pressed(1):
		$Lantern.global_position = $Lantern.global_position.linear_interpolate(mouse_pos, delta*FOLLOW_SPEED)
		lantern_grow()

	else:
		$Lantern.global_position = $Lantern.global_position.linear_interpolate(player_pos, delta*FOLLOW_SPEED) + lantern_pos
		lantern_shrink()


func lantern_grow():
	use_light += 1
	if use_light == 1:
		$Lantern/AnimationPlayer.play("grow")


func lantern_shrink():
	if use_light > 1:
		$Lantern/AnimationPlayer.play("shrink")
	elif use_light == -1:
		$Lantern/AnimationPlayer.play("RESET")


func _on_Timer_timeout():
	$AnimationPlayer.play("tut fade out")


func _on_Lantern_reset():
	use_light = -1


func _on_Spike_body_entered(body):
	if body.is_in_group("Player"):
		global.deaths += 1
		$AnimationPlayer.play("damage_spike")
		$Player/Hurt.play()
		$Player.damaged = true
		$Player.can_move = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "tut fade in":
		$Timer.start()
	
	if anim_name == "damage_enemy" or anim_name == "damage_spike":
		$AnimationPlayer.play("fade out")
	
	# Normal and Lights On mode
	if anim_name == "fade out" and not level_complete:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Screens/GameOver.tscn")
	elif anim_name == "fade out" and level_complete:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Screens/Scene2.tscn")
	
	# Speedrun mode
	if anim_name == "fade out" and not level_complete and global.speedrun:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/Level2.tscn")
	elif anim_name == "fade out" and level_complete and global.speedrun:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/Level3.tscn")


func _on_Light_body_entered(body):
	if body.is_in_group("Player"):
		level_complete = true
		$AnimationPlayer.play("fade out")
		Input.action_release("down")
		Input.action_release("up")
		Input.action_release("left")
		Input.action_release("right")



