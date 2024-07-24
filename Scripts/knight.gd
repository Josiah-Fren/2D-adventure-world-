extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0
@export var acceleration : float = 15.0
@export var jump = 1
@export var attacking = false


enum state {IDLE, RUNNING, JUMPUP, JUMPDOWN, HURT, ATTACK}

var  anim_state = state.IDLE

@onready var animator = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var start_pos = global_position


func reset():
	global_position = start_pos
	set_physics_process(true)
	anim_state = state.IDLE
		
func update_state():
	if anim_state == state.HURT:
		return
	if is_on_floor():
		if velocity == Vector2.ZERO:
			anim_state = state.IDLE
		elif velocity.x != 0:
			anim_state = state.RUNNING
		else:
			if velocity.y < 0:
				anim_state = state.JUMPUP
			else:
				anim_state = state.JUMPDOWN








func attack():
	var overlapping_objects = $Attackarea.get_overlapping_areas()
	for area in overlapping_objects:
		var parent = area.get_parent()
		print(parent.name)
	attacking = true
	anim_state = state.ATTACK
	update_state()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()
		animation_player.play("attack")
		anim_state = state.ATTACK
		update_state()
	
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x,direction*speed,acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)
		
	update_state()
	update_animation(direction)
	move_and_slide()
	
func enemy_checker(enemy):
	if enemy.is_in_group("Enemy") and velocity.y > 0:
		enemy.die()
		velocity.y = jump_velocity
	elif enemy.is_in_group("Hurt"):
		anim_state = state.HURT


func _on_hitbox_area_entered(area):
	enemy_checker(area)


func _on_hitbox_body_entered(body):
	enemy_checker(body)


func _on_area_2d_body_entered(body):
	if body.is_in_group("hurtbox"):
		body.take_damage()

func update_animation(direction):
	if  direction > 0:
		animator.flip_h = false
	elif direction < 0:
		animator.flip_h = true
	match anim_state:
		state.IDLE:
			animation_player.play("idle")
		state.RUNNING:
			animation_player.play("run")
		state.JUMPUP:
			animation_player.play("jump_up")
		state.JUMPDOWN:
			animation_player.play("jump_down")
		state.HURT:
			animation_player.play("hurt")
		state.ATTACK:
			animation_player.play("attack")

