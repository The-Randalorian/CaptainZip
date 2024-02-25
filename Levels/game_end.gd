extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("scroll")
	$CenterContainer/VBoxContainer2/VBoxContainer/StartButton.grab_focus()



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/main menu.tscn") # Replace with function body.

