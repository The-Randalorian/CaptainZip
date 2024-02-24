extends CharacterBody2D



const JUMP_VELOCITY = -300.0		# how much initial speed to put into a jump
const GROUND_SPEED = 300.0			# target speed on the ground
const GROUND_ACCELERATION = 0.05	# how fast to speed up on the ground
const GROUND_DECELERATION = 0.15	# how fast to slow down on the ground
const AIR_ACCELERATION = 300		# how fast to speed up in the air
const AIR_DECELERATION = 200		# how fast to slow down in the air
const PLATFORMING_FLOAT = 0.5		# how much we want to let the player float or glide by holding space
const ZIP_ANGLE_FORGIVENESS = 0.5	# how much of the players off-angle velocity we want to put into the zipline

const invincibilityTime = 0.5;		#player invincibility time (seconds)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var hook_offset = $HookPosition.position

var playerHealth = 3;
var invincible = false;

var timer;

#called when node and all children enter scene
func _ready():
	timer = Timer.new()
	timer.connect("timeout",_on_timer_timeout) 
	timer.set_wait_time(invincibilityTime) #value is in seconds: 600 seconds = 10 minutes
	timer.set_one_shot(true);
	add_child(timer) 

#called when timer reaches zero
func _on_timer_timeout():
	#print("on timer function called");
	invincible = false;
	#timer.reset() if needed?
	
	#your timer events start here


func _init():
	randomize()  # set up the random number generator globally


var allow_zip = true
var conn_zip = null


func attach_to_zip(zip):
	if conn_zip != zip and allow_zip:
		#on_zip = true
		conn_zip = zip
		var snap_x = clamp(position.x, zip.position.x, zip.position.x+zip.endpoint.x)
		var snap_pos = Vector2(snap_x, zip.get_snap_height(snap_x))
		position = snap_pos - hook_offset
		var snap_v = zip.get_snap_slope_vector(snap_x) * Vector2(1.0, -1.0)
		#print(snap_v)
		var new_v = snap_v.dot(velocity) * snap_v
		if new_v.length() < 50:
			velocity = new_v
			return
		velocity = new_v.normalized() * lerp(new_v.length(), velocity.length(), ZIP_ANGLE_FORGIVENESS)
		$Sprite2D.play("zip")
		$Sprite2D.position = Vector2(0, -18)
		allow_zip = false
		$Allow_Zip_Timer.start()
		$CPUParticles2D.emitting = false


func _physics_process(delta):
	if playerHealth <= 0:
		playerDeath();
	
	if conn_zip != null:
		zipline_physics_process(delta)
	else:
		ground_physics_process(delta)
		
	if timer.get_time_left() == 0:
		_on_timer_timeout();

func zipline_physics_process(delta):
	#position = connected_zipline.position
	
	velocity.y += gravity * delta
	
	var snap_v = conn_zip.get_snap_slope_vector(position.x) * Vector2(1.0, -1.0)
	
	velocity = snap_v.dot(velocity) * snap_v
	
	move_and_slide()
	
	# correct the position
	position = Vector2(position.x, conn_zip.get_snap_height(position.x)) - hook_offset
	
	if Input.is_action_just_pressed("move_jump"):
		velocity.y += JUMP_VELOCITY
		conn_zip = null
		allow_zip = false
		$Allow_Zip_Timer.start()
		$Sprite2D.play("jump")
		$Sprite2D.position = Vector2(0, -40)
		return
	
	if position.x + hook_offset.x < conn_zip.position.x or position.x + hook_offset.x > conn_zip.position.x + conn_zip.endpoint.x:
		velocity = snap_v.dot(velocity) * snap_v
		conn_zip = null
		$Allow_Zip_Timer.start()
	
	if velocity.x < -10:
		$Sprite2D.flip_h = true
	if velocity.x > 10:
		$Sprite2D.flip_h = false

func ground_physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_pressed("move_jump"):
			velocity.y += gravity * delta * PLATFORMING_FLOAT
		else:
			velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction < -0.05:
		$Sprite2D.flip_h = true
	if direction > 0.05:
		$Sprite2D.flip_h = false
		
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x, float(direction * GROUND_SPEED), GROUND_ACCELERATION * delta * 60)
		else:
			velocity.x = lerp(velocity.x, 0.0, GROUND_DECELERATION * delta * 60)
		
		$CPUParticles2D.direction.x = clamp(velocity.x, -1, 1)
		$CPUParticles2D.color_ramp.colors[0] = Color(Color(1, 1, 1), clamp(abs((velocity.x-50) / 100), 0, 1))
		$CPUParticles2D.emitting = abs(velocity.x) > 50
		if abs(velocity.x) > 50:
			$CPUParticles2D.emitting = true
			$Sprite2D.play("walk")
			$Sprite2D.position = Vector2(0, -40)
		else:
			$CPUParticles2D.emitting = false
			$Sprite2D.play("default")
			$Sprite2D.position = Vector2(0, -40)
		#$CPUParticles2D.amount = abs(round(velocity.x / 10))
	else:
		if direction:
			velocity.x = move_toward(velocity.x, float(direction * GROUND_SPEED), AIR_ACCELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0.0, AIR_DECELERATION * delta)
		$CPUParticles2D.emitting = false
	
	# Handle jump.
	#if Input.is_action_pressed("move_jump"):
	if is_on_floor():
		if Input.is_action_just_pressed("move_jump"):
			velocity.y = JUMP_VELOCITY
			$Sprite2D.play("jump")
			$Sprite2D.position = Vector2(0, -40)
		elif not $Jump_Limit_Timer.is_stopped():
			velocity.y = JUMP_VELOCITY
			$Sprite2D.play("default")
			$Sprite2D.position = Vector2(0, -40)
			$Jump_Anim_Delay_Timer.start()
	elif Input.is_action_just_pressed("move_jump"):
		$Jump_Limit_Timer.start()

	move_and_slide()


func _on_allow_zip_timer_timeout():
	allow_zip = true
	
func playerHit():
	#print(invincible);
	
	if !invincible:
		playerHealth -= 1;
		timer.set_wait_time(invincibilityTime);
		timer.start();
		invincible = true;
	
func playerDeath():
	get_tree().reload_current_scene();


func _on_jump_anim_delay_timer_timeout():
	$Sprite2D.play("jump")
	$Sprite2D.position = Vector2(0, -40)
