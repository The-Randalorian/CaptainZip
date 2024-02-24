#@Authors - Patrick
#@Description - enemy

extends Node2D

#direction collision
func _on_area_2d_body_entered(body):
	#only happens on collision with mask 32 (the player)
	print("there's a collision here");
	body.playerHit();
	
#p
	
#only called when player walks into shoot area
func canShoot(playerObj):
	pass
	
	
func shoot(playerObj):
	pass
	#shoot stuff
