#@Authors - David
#@Description - controls how parrots move

@tool

extends Area2D

var movement = Vector2(0, 0)
@export var flip_h = false:
	set(new_flip):
		flip_h = new_flip
		$AnimatedSprite2D.flip_h = flip_h

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += movement * delta


func _on_body_entered(_body):
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	var dir = randf_range(-160, 160)
	movement = Vector2(dir, -120)
	flip_h = dir < 0
	$AnimatedSprite2D.play("fly")
