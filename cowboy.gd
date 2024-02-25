#@Authors - Patrick
#@Description - cowboy actions

extends Node2D

const shootTime = 0.75;
const cooldownTime = 5;

var timer1;
var timer2;

var player;

var bulletScene = load("res://bullet.tscn");


func _ready():
	timer1 = Timer.new()
	timer1.connect("timeout",_on_timer_timeout) 
	timer1.set_wait_time(shootTime) #value is in seconds: 600 seconds = 10 minutes
	timer1.set_one_shot(true);
	add_child(timer1)
	
	timer2 = Timer.new()
	timer2.connect("timeout",_on_timer_timeout) 
	timer2.set_wait_time(cooldownTime) #value is in seconds: 600 seconds = 10 minutes
	timer2.set_one_shot(true);
	add_child(timer2)  

func _on_timer_timeout():
	if timer2.get_time_left() == 0:
		shoot(player);



#direction collision
func _on_area_2d_body_entered(body):
	#only happens on collision with mask 32 (the player)
	#print("there's a collision here");
	
	#hacky way of doing it, but it's a damn game jam
	if body.atKillingVelocity():
		cowboyDeath();
	else:
		body.playerHit();

#player is in shoot range
func _on_area_2d_2_body_entered(body):
	#print("player is in shoot range");
	player = body;
	
	timer1.set_wait_time(shootTime);
	timer1.start();
	
	#shoot(body);
		
func shoot(playerObj):
	$Sprite2D.play("shoot");
	var bulletNode = bulletScene.instantiate();
	#automatically spawns at cowboy's location
	add_child(bulletNode);  # add it to the current node
	
	#makes it look like it's coming out of cowboy's gun
	bulletNode.position.x -= 25;
	bulletNode.position.y -= 11;
	
	timer2.set_wait_time(cooldownTime);
	timer2.start();
	#turns to face player
	
func cowboyDeath():
	queue_free();
