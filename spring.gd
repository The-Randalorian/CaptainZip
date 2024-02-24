extends Area2D


@export var strength = 1000
var allow_spring = true


func _on_body_entered(body):
	if allow_spring and not $AnimatedSprite2D.is_playing():
		body.velocity.y = -strength
		allow_spring = false
		$AnimatedSprite2D.play("default")


func _on_animated_sprite_2d_animation_finished():
	allow_spring = true
