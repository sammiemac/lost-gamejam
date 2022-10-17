extends Control


onready var global = get_node("/root/Global")


func _ready():
	$AnimationPlayer.play("fade in")


func _on_Button_pressed():
	print("pressed")
	$AnimationPlayer.play("fade out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade out":
		if global.level == 2:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Levels/Level2.tscn")
		if global.level == 3:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Levels/Level3.tscn")
