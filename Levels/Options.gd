extends Control
var EditStr = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_buttonChange_press(option):
	EditStr = option

func _input(event):
	if event is InputEventKey and EditStr != null:
		if event.pressed:
			var temp = EditStr
			if temp != "":
				EditStr = ""
				InputMap.action_erase_events(temp)
				InputMap.action_add_event(temp, event)
				var labelEdit = get_node("%" + temp + "_label")
				if labelEdit != null:
					labelEdit.text = event.as_text_key_label()
			

func _on_jump_pressed():
	_on_buttonChange_press("move_jump")


func _on_move_right_pressed():
	_on_buttonChange_press("move_right")


func _on_move_left_pressed():
	_on_buttonChange_press("move_left")
