extends CharacterBody2D
class_name Archer


var a
@onready var  arrow = preload("res://Scripts/UI/arrow.tscn")
@onready var jumping: AudioStreamPlayer2D = $Jumping
@onready var footsteps: AudioStreamPlayer2D = $Footsteps


@onready var animation = $AnimationPlayer
@onready var sprite = $Sprites

@export var speed = 300.0
@export var jump_height = -400.0

@export var attacking = false
@export var death = false
var max_health = 2
var health = 0
var can_take_damage = true


func _ready():
	health = max_health
	GameManager.player = self

func shoot():
		a = arrow.instance()
		add_child(a)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()
		a = arrow.instantiate()
		add_sibling(a)
		a.global_position = global_position
		a.direction = sprite.scale.x
		print(attack)
		
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
		jumping.play()

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
		
func attack():
	attacking = true
	animation.play("Attack")
	update_animation()




func update_animation():
	if !attacking:
		if velocity.x != 0:
			animation.play("Run")
		else:
			animation.play("Idle")
		if velocity.y < 0:
			animation.play("Jump")
		if velocity.y > 0:
			animation.play("Fall")

func take_damage(damage_amount : int):
	if can_take_damage:
		iframes()
		
		health -= damage_amount
		
		
		if health <= 0:
			die()

func iframes():
	can_take_damage = false
	await  get_tree().create_timer(1).timeout
	can_take_damage = true
	


func die():
	death = true
	GameManager.respawn_player()
	
