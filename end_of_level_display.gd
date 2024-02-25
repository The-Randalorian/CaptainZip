extends Control

var level_running = true

var display_showing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$view_blocker.color = Color("000000ff")
	$view_blocker.visible = true
	$AnimationPlayer.play("start_level")
	start_timer()

var queued_level:String

func end_level(next_level):
	if level_running:
		stop_timer()
		$AnimationPlayer.play("show_stats")
		level_running = false
		display_showing = true
		queued_level = next_level

func level_ended():
	get_tree().call_deferred("change_scene_to_file", queued_level)

func _process(_delta):
	if display_showing and Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("end_level")
		display_showing = false
		

var start_time = 0
var stop_time = 0

func start_timer():
	start_time = Time.get_ticks_usec()

func stop_timer():
	stop_time = Time.get_ticks_usec()
	var total_seconds = (stop_time - start_time) * 0.000001
	print(total_seconds)
	var minutes = floor(total_seconds / 60)
	var seconds = total_seconds - (minutes * 60)
	var time_string = ("%02d" % minutes) + ":" + ("%02.3f" % seconds)
	$CenterContainer/VBoxContainer/GridContainer/time_value.text = time_string
	if total_seconds < 30:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "S"
	elif total_seconds < 60:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "A"
	elif total_seconds < 90:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "B"
	elif total_seconds < 120:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "C"
	elif total_seconds < 150:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "D"
	else:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "F"
