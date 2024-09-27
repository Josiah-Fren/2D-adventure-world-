extends CharacterBody2D

class_name Skeleton
@onready var animation = $AnimationPlayer
@onready var death_sound: AudioStreamPlayer2D = $"Death sound"


var direction = 1 # these are the direction for the mob to go either left or right
const SPEED = 100.0 # speed of the skeleton when it moves


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



@onready var animator = $AnimatedSprite2D



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta 

	# Handle jump.
	velocity.x = direction * SPEED # based on the speed and velocity it determins how it moves

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	move_and_slide()
	$AnimatedSprite2D.flip_h = direction > 0 # the sprite flips itself based on the direction of the skeleton
	
	

func _on_timer_timeout():
	direction = direction * -1 # Based on the timer it will flip the direction of the skeleton



func die():
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Archer:
		area.get_parent().take_damage(1)
	if area.get_parent() is Arrow:
		death_sound.play()
		$AnimationPlayer.play("Die")
		await animator.animation_finished
		die()
