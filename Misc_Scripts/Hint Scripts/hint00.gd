extends Hint

var lMove = "A"
var rMove = "D"

# Called when the node enters the scene tree for the first time.
func _ready():
	lMove = _event_to_string(InputMap.action_get_events("move_left")[0],"A")
	rMove = _event_to_string(InputMap.action_get_events("move_right")[0],"D")
	self.set_text(lMove + " and " + rMove + "\n     to move")
	
