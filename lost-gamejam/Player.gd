extends KinematicBody2D


export var velocity = Vector2(0,0)
const PLAYER_SPEED = 300
const PLAYER_JUMP = -700
const GRAVITY = 30

const FOLLOW_SPEED = 4.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# Handles walking and idle animations and motion
	if Input.is_action_pressed("right"):
		velocity.x = PLAYER_SPEED
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	elif Input. is_action_pressed("left"):
		velocity.x = -PLAYER_SPEED
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")
	
	# Set fall speed
	velocity.y = velocity.y + GRAVITY
	
	# Handles jumping and falling animations and motion
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = PLAYER_JUMP
	
	# Handles basic movement
	velocity = move_and_slide(velocity, Vector2.UP, false)
	
	# When player stops, slow down motion
	velocity.x = lerp(velocity.x, 0, 0.2)
	
	var player_pos = position
	
	$Lantern.position = $Lantern.position.linear_interpolate(player_pos, delta*FOLLOW_SPEED)
	
