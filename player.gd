extends CharacterBody2D



const JUMP_VELOCITY = -250.0		# how much initial speed to put into a jump
const GROUND_SPEED = 300.0			# target speed on the ground
const GROUND_ACCELERATION = 300.0	# how fast to speed up
const GROUND_DECELERATION = 200.0	# how fast to slow down
const PLATFORMING_FLOAT = 0.5		# how much we want to let the player float or glide by holding space

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _init():
	randomize()  # set up the random number generator globally


var on_zip = false
var connected_zipline = null


func attach_to_zip(zip):
	if connected_zipline != zip:
		on_zip = true
		connected_zipline = zip


func _physics_process(delta):
	if on_zip:
		zipline_physics_process(delta)
	else:
		ground_physics_process(delta)

func zipline_physics_process(delta):
	position = connected_zipline.position

func ground_physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_pressed("move_jump"):
			velocity.y += gravity * delta * PLATFORMING_FLOAT
		else:
			velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * GROUND_SPEED, GROUND_ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, GROUND_DECELERATION * delta)
	
	if is_on_floor():
		$CPUParticles2D.direction.x = clamp(velocity.x, -1, 1)
		$CPUParticles2D.color_ramp.colors[0] = Color(Color(1, 1, 1), clamp(abs((velocity.x-50) / 100), 0, 1))
		$CPUParticles2D.emitting = abs(velocity.x) > 50
		#$CPUParticles2D.amount = abs(round(velocity.x / 10))
	else:
		$CPUParticles2D.emitting = false

	move_and_slide()
