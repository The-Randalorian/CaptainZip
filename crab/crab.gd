extends Node2D

#direction collision
func _on_area_2d_body_entered(body):
	#only happens on collision with mask 32 (the player)
	#print("there's a collision here");
	body.playerHit();

func _ready():
	$editor_area.visible = false
	$AnimationPlayer.play("default")
	
