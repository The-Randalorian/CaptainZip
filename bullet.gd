extends CharacterBody2D

const bulletVelocity = -150;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(_delta):
	velocity.x = bulletVelocity;
	move_and_slide();

#collision with player
func _on_area_2d_body_entered(body):
	print("player has collided with bullet");
	
	body.playerHit();
	#deletes node from scene
	bulletDespawn();
	
#collision with anything else
func _on_area_2d_2_body_entered(_body):
	bulletDespawn();
	
func bulletDespawn():
	queue_free();



