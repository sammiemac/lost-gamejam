extends TextureRect


func _ready():
	$AnimationPlayer.play("fade in")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade in":
		$Timer.start()
	
	if anim_name == "fade out":
		get_tree().change_scene("res://Levels/Level2.tscn")


func _on_Timer_timeout():
	$AnimationPlayer.play("fade out")
