extends CharacterBody2D


@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_dead = false


func _physics_process(delta):
	if not is_dead:
		handle_player_actions(delta)
	else:
		# Drop to the floor
		if not is_on_floor():
			velocity.y += gravity * delta
			move_and_slide()
	

func handle_player_actions(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	# If moving, flip sprite when facing left
	if direction != 0:
		animated_sprite.flip_h = direction < 0 
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func play_death_sequence():
	if not is_dead:
		is_dead = true
		Engine.time_scale = 0.4
		animated_sprite.play("death")
