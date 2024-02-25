extends Node2D

#direction collision
func _on_area_2d_body_entered(body):
	#only happens on collision with mask 32 (the player)
	#print("there's a collision here");
	
	#hacky way of doing it, but it's a damn game jam
	if body.atKillingVelocity():
		crabDeath();
	else:
		body.playerHit();
	
	
	body.playerHit();

func _ready():
	$editor_area.visible = false
	$AnimationPlayer.play("default")
	
func crabDeath():
	queue_free();
