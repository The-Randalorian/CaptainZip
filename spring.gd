extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


@export var strength = 1000


func _on_body_entered(body):
	if not $AnimatedSprite2D.is_playing():
		body.velocity.y -= strength
		$AnimatedSprite2D.play("default")
