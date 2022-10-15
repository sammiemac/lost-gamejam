extends Node2D


onready var global = get_node("/root/Global")


const FOLLOW_SPEED = 4.0
const ENEMY_SPEED = 0.5
var lantern_pos = Vector2(-2, 0)

var level_complete = false
var enemy_light = false
var hit_player = false
var use_light = -1 # -1 = reset


func _ready():
	global.level = 2
	$AnimationPlayer.play("fade in")
	$AnimationPlayer.play("tut fade in")


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
	
#	# If the enemy is in the light, it stops
#	if enemy_light:
#		$Enemy/LanternDetect.disabled = false
#		$Enemy/EnemyCollision/CollisionShape2D.disabled = true
#		$Enemy/Platform.disabled = false
#	else:
#		$Enemy.global_position = $Enemy.global_position.linear_interpolate(player_pos, delta*ENEMY_SPEED)
#		$Enemy/LanternDetect.disabled = true
#		$Enemy/EnemyCollision/CollisionShape2D.disabled = false
#		$Enemy/Platform.disabled = true
	
	if hit_player:
		$Enemy/LanternDetect.disabled = true
	else:
		$Enemy/LanternDetect.disabled = false


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


func _on_Lantern_enemy_enter():
	$Enemy/AnimatedSprite.play("idle")
	enemy_light = true


func _on_Lantern_enemy_exit():
	$Enemy/AnimatedSprite.play("default")
	enemy_light = false


func _on_Enemy_player_hit():
	hit_player = true
	$AnimationPlayer.play("damage_enemy")


func _on_Enemy_player_leave():
	hit_player = false
	$AnimationPlayer.play("no_damage")


func _on_Lantern_reset():
	use_light = -1


func _on_Spike_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("damage_spike")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "tut fade in":
		$Timer.start()
	
	if anim_name == "damage_enemy" or anim_name == "damage_spike":
		$AnimationPlayer.play("fade out")

	if anim_name == "fade out" and not level_complete:
		get_tree().change_scene("res://Levels/GameOver.tscn")
	elif anim_name == "fade out" and level_complete:
#		print("change scene")
		get_tree().change_scene("res://Levels/Scene2.tscn")


func _on_Light_body_entered(body):
	if body.is_in_group("Player"):
		level_complete = true
		$AnimationPlayer.play("fade out")



