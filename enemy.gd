#@Authors - Patrick
#@Description - enemy

extends Node2D

func _on_area_2d_body_entered(body):
	#only happens on collision with mask 32 (the player)
	print("there's a collision here");
	body.playerHit();
	

func shoot():
	pass
	#shoot stuff
