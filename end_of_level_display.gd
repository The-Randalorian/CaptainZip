#@Authors - David
#@Description - display for rank and time. Can be modified with inspector for each level

extends Control

var level_running = true

var display_showing = false

@export var s_rank = 30.0
@export var a_rank = 60.0
@export var b_rank = 90.0
@export var c_rank = 120.0
@export var d_rank = 150.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$view_blocker.color = Color("000000ff")
	$view_blocker.visible = true
	$AnimationPlayer.play("start_level")
	start_timer()

var queued_level:String

func end_level(next_level, levelNum):
	#print(next_level);
	if level_running:
		stop_timer()
		$AnimationPlayer.play("show_stats")
		level_running = false
		display_showing = true
		queued_level = next_level
		var serializeInstance = Serializer.new();
		serializeInstance.setupSave(levelNum);

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
	if total_seconds < s_rank:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "S"
	elif total_seconds < a_rank:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "A"
	elif total_seconds < b_rank:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "B"
	elif total_seconds < c_rank:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "C"
	elif total_seconds < d_rank:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "D"
	else:
		$CenterContainer/VBoxContainer/GridContainer/rank_value.text = "F"

#func setupSave(lNum):
	##prevents levelsCompleted from incrementing when it shouldn't
	#GameManager.numLevelsCompleted = min(lNum, GameManager.numLevelsCompleted + 1);
	##print(GameManager.numLevelsCompleted);
	#
	#var serializeInstance = Serializer.new();
	#serializeInstance.completedLevels = GameManager.numLevelsCompleted;
	#
	#var cNum = ResourceSaver.save(serializeInstance, "user://CoolData.res");
	#assert(cNum == OK)
