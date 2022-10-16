extends KinematicBody2D


var velocity = Vector2(0,0)
export var player_speed = 300
export var player_jump = -700
const GRAVITY = 30

var damaged = false
var can_move = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	# Handles walking and idle animations and motion
	if Input.is_action_pressed("right") and can_move:
		velocity.x = player_speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	elif Input. is_action_pressed("left") and can_move:
		velocity.x = -player_speed
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	else:
		#$AnimatedSprite.play("light")
		$AnimatedSprite.play("idle")
	
	# Set fall speed
	velocity.y = velocity.y + GRAVITY
	
	# Handles jumping and falling animations and motion
	if Input.is_action_just_pressed("up") and is_on_floor() and can_move:
		velocity.y = player_jump
	
	# Handles basic movement
	velocity = move_and_slide(velocity, Vector2.UP, false)
	
	# When player stops, slow down motion
	velocity.x = lerp(velocity.x, 0, 0.2)
	
	# Locks player movement if moving lantern
	if Input.is_mouse_button_pressed(1):
		$AnimatedSprite.play("light")
		can_move = false
	elif not damaged:
		can_move = true
	
	if damaged:
		$CollisionShape2D.disabled = true
	
	

