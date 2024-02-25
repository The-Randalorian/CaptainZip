extends Camera2D

@export var player_object_path:NodePath
@export var next_level:String

var player_object

var velocity = Vector2(0.0, 0.0)

const CAMERA_ACCELERATION = 1.80
const CAMERA_DAMPING = 0.80
var camera_offset = Vector2(0, -27)

# Called when the node enters the scene tree for the first time.
func _ready():
	player_object = get_node(player_object_path)
	global_position = player_object.global_position + camera_offset
	$transition_handler.visible = true
	$whistle.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var error = player_object.global_position + camera_offset - global_position
	
	velocity += error * delta * 60 * CAMERA_ACCELERATION
	
	velocity *= CAMERA_DAMPING
	
	global_position += velocity * delta

var level_running = true

func end_level():
	if level_running:
		$transition_handler.end_level(next_level)
		$gong.play()
		level_running = false
