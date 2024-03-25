#@Authors - Eric
#@Description - skips intro

extends Label

func _input(event):
	if event.is_action("move_jump"):
		get_tree().change_scene_to_file("res://Levels/level 1.tscn")
