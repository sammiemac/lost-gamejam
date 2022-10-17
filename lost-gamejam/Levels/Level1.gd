extends Node2D


onready var global = get_node("/root/Global")
onready var music = get_node("/root/Music")


func _ready():
	$AnimationPlayer.play("fade in")
	music.play_music()
	if global.lights_on:
		$Shadow.visible = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
#		print("player enter")
		$AnimationPlayer.play("fade out")
		Input.action_release("down")
		Input.action_release("up")
		Input.action_release("left")
		Input.action_release("right")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade in":
		$AnimationPlayer.play("hover")
	if anim_name == "fade out":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Screens/Scene1.tscn")
