extends Control

var EditStr = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Options.visible = false
	$VBoxContainer.visible = true
	visible = false
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if visible:
			if $Options.visible:
				_on_main_menu_pressed()
			else:
				_on_resume_button_pressed()
		else:
			visible = true
			get_tree().paused = true


func _on_option_button_pressed():
	$Options.visible = true
	$VBoxContainer.visible = false
	visible = true
	get_tree().paused = true


func _on_main_menu_pressed():
	$Options.visible = false
	$VBoxContainer.visible = true
	visible = true
	get_tree().paused = true


func _on_resume_button_pressed():
	visible = false
	get_tree().paused = false

func _on_buttonChange_press(option):
	EditStr = option

func _input(event):
	if(EditStr != null):
		if (event is InputEventKey or event is InputEventJoypadButton) and event.pressed:
				var remapText = ""
				if event is InputEventKey:
					remapText = event.as_text_key_label()
				elif event is InputEventJoypadButton:
					remapText = "Button " + str(event.button_index)
				_changeInputText(event,remapText)
		if event is InputEventJoypadMotion and (event.axis_value > 0.8 or event.axis_value < -0.8):
				_changeInputText(event,"axis " + str(event.get_axis()))
		accept_event()
			

func _changeInputText(event,labelText):
	var temp = EditStr
	if temp != "":
		EditStr = null
		InputMap.action_erase_events(temp)
		InputMap.action_add_event(temp, event)
		var labelEdit = get_node("%" + temp + "_label")
		if labelEdit != null:
			labelEdit.text = labelText

func _on_jump_pressed():
	_on_buttonChange_press("move_jump")


func _on_move_right_pressed():
	_on_buttonChange_press("move_right")


func _on_move_left_pressed():
	_on_buttonChange_press("move_left")


func _on_detach_pressed():
	_on_buttonChange_press("move_detach")

