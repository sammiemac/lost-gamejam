extends StaticBody2D


signal player_hit
signal player_leave


func _ready():
	$AnimatedSprite.play("default")


func _on_EnemyCollision_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("player_hit")
		print("player hit")


func _on_EnemyCollision_body_exited(body):
	if body.is_in_group("Player"):
		emit_signal("player_leave")
		print("player leave")
