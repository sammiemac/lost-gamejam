extends TextureRect


func _ready():
	$AnimationPlayer.play("fade in")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade in":
		$Timer.start()


func _on_Timer_timeout():
	$AnimationPlayer.play("fade out")
