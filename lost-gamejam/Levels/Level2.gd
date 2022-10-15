extends Node2D


const FOLLOW_SPEED = 4.0
const ENEMY_SPEED = 0.5
var lantern_pos = Vector2(-2, 0)
var reverse = Vector2(-1, -1)
var enemy_light = false
var hit_player = false

func _physics_process(delta):
	
	var player_pos = $Player.global_position
	var mouse_pos = get_global_mouse_position()
	
	# If holding left-click, lantern follows mouse. Else, follows player
	if Input.is_mouse_button_pressed(1):
		$Lantern.global_position = $Lantern.global_position.linear_interpolate(mouse_pos, delta*FOLLOW_SPEED)
	else:
		$Lantern.global_position = $Lantern.global_position.linear_interpolate(player_pos, delta*FOLLOW_SPEED) + lantern_pos
	
	# If the enemy is in the light, it stops
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



func _on_Lantern_enemy_enter():
	$Enemy/AnimatedSprite.play("idle")
	enemy_light = true


func _on_Lantern_enemy_exit():
	$Enemy/AnimatedSprite.play("default")
	enemy_light = false


func _on_Enemy_player_hit():
	hit_player = true
	$AnimationPlayer.play("damage")


func _on_Enemy_player_leave():
	hit_player = false
	$AnimationPlayer.play("no_damage")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "damage":
		get_tree().change_scene("res://Levels/GameOver.tscn")



