extends Camera2D

@export var player_object_path:NodePath

var player_object

var velocity = Vector2(0.0, 0.0)

const CAMERA_ACCELERATION = 1.80
const CAMERA_DAMPING = 0.80
var camera_offset = Vector2(0, -27)

# Called when the node enters the scene tree for the first time.
func _ready():
	player_object = get_node(player_object_path)
	global_position = player_object.global_position + camera_offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var error = player_object.global_position + camera_offset - global_position
	
	velocity += error * delta * 60 * CAMERA_ACCELERATION
	
	velocity *= CAMERA_DAMPING
	
	global_position += velocity * delta

func end_level():
	$transition_handler.end_level()
