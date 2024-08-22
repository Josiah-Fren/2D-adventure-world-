extends CharacterBody2D
class_name Archer


@onready var animation = $AnimationPlayer
@onready var sprite = $Sprites

@export var speed = 300.0
@export var jump_height = -400.0

@export var attacking = false

func _ready():
	GameManager.player = self

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if Input.is_action_pressed("left"):
		sprite.scale.x =abs(sprite.scale.x) * -1
	if Input.is_action_pressed("right"):
		sprite.scale.x =abs(sprite.scale.x) 

	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_height

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	update_animation()
	move_and_slide()



	
	if position.y >=2000:
		die()

func update_animation():
	if velocity.x != 0:
		animation.play("Run")
	else:
		animation.play("Idle")
	
	if velocity.y < 0:
		animation.play("Jump")
	if velocity.y > 0:
		animation.play("Fall")


func die():
	GameManager.respawn_player()
