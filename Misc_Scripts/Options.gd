#@Authors - Eric
#@Description - options menu

extends Control
var EditStr = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("scroll")

	
			
	$CenterContainer/VBoxContainer/GridContainer/Level1Button.disabled = false;
	
			
	$CenterContainer/VBoxContainer/GridContainer/Level2Button.disabled  = GameManager.numLevelsCompleted < 1;
	
			
	$CenterContainer/VBoxContainer/GridContainer/Level3Button.disabled = GameManager.numLevelsCompleted < 2;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Levels/main menu.tscn") # Replace with function body.


func _on_level_1_button_pressed():
	if (GameManager.numLevelsCompleted >= 0):
		get_tree().change_scene_to_file("res://Levels/level 1.tscn")


func _on_level_2_button_pressed():
	#this is not a typo! Levels 2 and 3 are swapped!
	if (GameManager.numLevelsCompleted >= 1):
		get_tree().change_scene_to_file("res://Levels/level 3.tscn")


func _on_level_3_button_pressed():
	if (GameManager.numLevelsCompleted >= 2):
		get_tree().change_scene_to_file("res://Levels/level 2.tscn")
