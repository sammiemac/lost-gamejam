extends Node2D


onready var global = get_node("/root/Global")


const FOLLOW_SPEED = 4.0
var lantern_pos = Vector2(-2, 0)


var level_complete = false
var use_light = -1 # -1 = reset


func _ready():
	global.level = 3
	
	$AnimationPlayer.play("fade in")
	
	if global.checkpoint == 0:
		$AnimationPlayer.play("tut fade in")
	else:
		$AnimationPlayer.play("tut off")
	
	if global.checkpoint == 1:
		global.scene_done = true
	
	use_light = -1
	
	$Player.position = global.player_start


func _process(_delta):
	if Input.is_action_just_pressed("restart"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/Level3.tscn")


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
	
	if global.checkpoint >= 1:
		$Checkpoints/Lamp/CollisionShape2D.disabled = true
		$Checkpoints/Lamp/Light2D.visible = true
		$Checkpoints/Lamp/AnimatedSprite.play("on")
		if not global.scene_done:
			$AnimationPlayer.play("scene fade out")
			Input.action_release("down")
			Input.action_release("up")
			Input.action_release("left")
			Input.action_release("right")

	if global.checkpoint >= 2:
		$Checkpoints/Lamp2/CollisionShape2D.disabled = true
		$Checkpoints/Lamp2/Light2D.visible = true
		$Checkpoints/Lamp2/AnimatedSprite.play("on")

	if global.checkpoint >= 3:
		$Checkpoints/Lamp3/CollisionShape2D.disabled = true
		$Checkpoints/Lamp3/Light2D.visible = true
		$Checkpoints/Lamp3/AnimatedSprite.play("on")

	if global.checkpoint >= 4:
		$Checkpoints/Lamp4/CollisionShape2D.disabled = true
		$Checkpoints/Lamp4/Light2D.visible = true
		$Checkpoints/Lamp4/AnimatedSprite.play("on")


func lantern_grow():
	use_light += 1
	if use_light == 1:
		$Lantern/AnimationPlayer.play("grow")


func lantern_shrink():
	if use_light > 1:
		$Lantern/AnimationPlayer.play("shrink")
	elif use_light == -1:
		$Lantern/AnimationPlayer.play("RESET")


func _on_Lantern_reset():
	use_light = -1


func _on_Timer_timeout():
	$AnimationPlayer.play("tut fade out")


func _on_Spike_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("damage_spike")
		$Player/Hurt.play()
		$Player.damaged = true
		$Player.can_move = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "tut fade in":
		$Timer.start()

	if anim_name == "damage_spike":
		$AnimationPlayer.play("fade out")

	if anim_name == "fade out" and not level_complete:
		global.deaths += 1
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/GameOver.tscn")
	elif anim_name == "fade out" and level_complete:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/Scene4.tscn")
	
	if anim_name == "scene fade out":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Levels/Scene3.tscn")


func _on_Light_body_entered(body):
	if body.is_in_group("Player"):
		level_complete = true
		$AnimationPlayer.play("fade out")
		Input.action_release("down")
		Input.action_release("up")
		Input.action_release("left")
		Input.action_release("right")


func _on_Lamp_body_entered(body):
	if body.is_in_group("Player"):
		global.checkpoint += 1
		global.player_start = $Player.position
