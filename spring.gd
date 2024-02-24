extends Area2D


@export var strength = 1000


func _on_body_entered(body):
	if not $AnimatedSprite2D.is_playing():
		body.velocity.y -= strength
		$AnimatedSprite2D.play("default")
