extends Control

var level_running = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$view_blocker.color = Color("000000ff")
	$view_blocker.visible = true
	$AnimationPlayer.play("start_level")


func end_level():
	if level_running:
		$AnimationPlayer.play("end_level")
		level_running = false

func level_ended():
	get_tree().call_deferred("reload_current_scene")
