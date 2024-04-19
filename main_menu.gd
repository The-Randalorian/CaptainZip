#@Authors - Eric
#@Description - main menu

extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("scroll")
	$CenterContainer/VBoxContainer2/VBoxContainer/StartButton.grab_focus()
	if OS.has_feature("web"):  # quitting on web crashes the game weirdly
		$CenterContainer/VBoxContainer2/VBoxContainer/QuitButton.visible = false
		
	#Enables fullscreen. We can turn this into a button if we want
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
	
	#loads number of completed levels. Use this as reference for level select menu
	var serializeInstance = Serializer.new();
	var serializedInfo = serializeInstance.load_data("user://CoolData.res");
	
	if (serializedInfo != null):
		GameManager.numLevelsCompleted = serializedInfo.completedLevels;
	
	
	if (GameManager.numLevelsCompleted == null):
		GameManager.numLevelsCompleted = 0;
	
	print("Completed levels: " + str(GameManager.numLevelsCompleted));



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/video_stream_player.tscn") # Replace with function body.


func _on_quit_button_button_down():
	get_tree().quit()


func _on_option_button_button_down():
	get_tree().change_scene_to_file("res://Levels/Options.tscn")
