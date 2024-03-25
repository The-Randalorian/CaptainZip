#@Authors - Eric
#@Description - main menu

extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("scroll")
	$CenterContainer/VBoxContainer2/VBoxContainer/StartButton.grab_focus()
	if OS.has_feature("web"):  # quitting on web crashes the game weirdly
		$CenterContainer/VBoxContainer2/VBoxContainer/QuitButton.visible = false



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/video_stream_player.tscn") # Replace with function body.


func _on_quit_button_button_down():
	get_tree().quit()


func _on_option_button_button_down():
	get_tree().change_scene_to_file("res://Levels/Options.tscn")
