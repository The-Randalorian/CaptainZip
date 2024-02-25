extends Label

class_name Hint

func _event_to_string(event,default = ""):
	if event is InputEventKey:
		self.set_process_input(false)
		return event.as_text_physical_keycode()
	elif event is InputEventJoypadButton:
		self.set_process_input(false)
		return "Button " + str(event.button_index)
	elif event is InputEventJoypadMotion:
		self.set_process_input(false)
		return "Axis " + str(event.axis)
	else:
		return default

func _event_string_to_string(eventName,default):
	return _event_to_string(InputMap.action_get_events(eventName)[0],default)
