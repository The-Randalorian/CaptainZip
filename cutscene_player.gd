extends VideoStreamPlayer


func _on_finished(next_scene):
	get_tree().call_deferred("change_scene_to_file", next_scene)
