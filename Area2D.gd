extends CharacterBody2D

var direction = 1
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	velocity.x = direction * SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	move_and_slide()
	$AnimatedSprite2D.flip_h = direction > 0


func _on_timer_timeout():
	direction = direction * -1 # Replace with function body.
