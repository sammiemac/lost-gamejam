extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal enemy_enter
signal enemy_exit


func _on_EnemyDetect_body_entered(body):
	print("latern body enter")
	if body.is_in_group("Enemy"):
		print("enemy entered")
		emit_signal("enemy_enter")


func _on_EnemyDetect_body_exited(body):
	print("latern body exit")
	if body.is_in_group("Enemy"):
		print("enemy exit")
		emit_signal("enemy_exit")
