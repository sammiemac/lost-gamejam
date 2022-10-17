extends Control


onready var global = get_node("/root/Global")
onready var music = get_node("/root/Music")


func _ready():
	$AnimationPlayer.play("fade in")
	music.play_music()


func _on_Normal_mouse_entered():
	$Panel/TextNormal.visible = true


func _on_LightsOn_mouse_entered():
	$Panel/TextLightsOn.visible = true


func _on_Speedrun_mouse_entered():
	$Panel/TextSpeedrun.visible = true


func _on_Normal_mouse_exited():
	$Panel/TextNormal.visible = false


func _on_LightsOn_mouse_exited():
	$Panel/TextLightsOn.visible = false


func _on_Speedrun_mouse_exited():
	$Panel/TextSpeedrun.visible = false


func _on_Normal_pressed():
	$Panel/Normal.disabled = true
	$Panel/LightsOn.disabled = true
	$Panel/Speedrun.disabled = true
	$AnimationPlayer.play("fade out")


func _on_LightsOn_pressed():
	global.lights_on = true
	$Panel/Normal.disabled = true
	$Panel/LightsOn.disabled = true
	$Panel/Speedrun.disabled = true
	$AnimationPlayer.play("fade out")


func _on_Speedrun_pressed():
	global.speedrun = true
	$Panel/Normal.disabled = true
	$Panel/LightsOn.disabled = true
	$Panel/Speedrun.disabled = true
	$AnimationPlayer.play("fade out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade out":
		if global.speedrun:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Levels/Level2.tscn")
		else:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Levels/Level1.tscn")
