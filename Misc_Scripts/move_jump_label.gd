extends Hint


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = _event_string_to_string("move_jump","Space")
