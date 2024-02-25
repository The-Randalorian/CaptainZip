extends Label

class_name Hint

func _event_to_string(event,default = ""):
	if event is InputEventKey:
		return event.as_text_physical_keycode()
	elif event is InputEventJoypadButton:
		return "Button " + str(event.button_index)
	elif event is InputEventJoypadMotion:
		return "Axis " + str(event.axis)
	else:
		return default
