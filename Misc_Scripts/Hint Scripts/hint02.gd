extends Hint
var jump = "Space"

# Called when the node enters the scene tree for the first time.
func _ready():
	jump = _event_to_string(InputMap.action_get_events("move_jump")[0],"Space")
	self.text = "Hold " + jump + "\n  to jump further..."
