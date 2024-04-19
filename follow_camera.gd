#@Authors - David
#@Description - camera functionality, including stopping once player finishes level

extends Camera2D

@export var player_object_path:NodePath
@export var next_level:String

var player_object

var velocity = Vector2(0.0, 0.0)

const CAMERA_ACCELERATION = 1.80
const CAMERA_DAMPING = 0.80
var camera_offset = Vector2(0, -27)

@export var s_rank = 30.0
@export var a_rank = 60.0
@export var b_rank = 90.0
@export var c_rank = 120.0
@export var d_rank = 150.0

@export var levelNum = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	player_object = get_node(player_object_path)
	global_position = player_object.global_position + camera_offset
	$transition_handler.visible = true
	$whistle.play()
	$transition_handler.s_rank = s_rank
	$transition_handler.a_rank = a_rank
	$transition_handler.b_rank = b_rank
	$transition_handler.c_rank = c_rank
	$transition_handler.d_rank = d_rank


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var error = player_object.global_position + camera_offset - global_position
	
	velocity += error * delta * 60 * CAMERA_ACCELERATION
	
	velocity *= CAMERA_DAMPING
	
	global_position += velocity * delta
	#$Label.position = global_position

var level_running = true

func end_level():
	if level_running:
		$transition_handler.end_level(next_level, levelNum)
		$Label.visible = false
		$gong.play()
		level_running = false
