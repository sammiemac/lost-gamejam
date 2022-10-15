extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal enemy_enter
signal enemy_exit
signal reset


func _on_EnemyDetect_body_entered(body):
	if body.is_in_group("Enemy"):
		print("enemy enter lantern")
		emit_signal("enemy_enter")


func _on_EnemyDetect_body_exited(body):
	if body.is_in_group("Enemy"):
		print("enemy exit lantern")
		emit_signal("enemy_exit")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "shrink":
		emit_signal("reset")
