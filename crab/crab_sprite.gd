extends Sprite2D


func _on_timer_timeout():
	flip_h = not flip_h

func _ready():
	$Timer.start()
