extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$view_blocker.visible = true
	$view_blocker.color = Color("ffffffff")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
