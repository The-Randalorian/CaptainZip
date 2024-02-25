#@Authors - Patrick
#@Description - cowboy actions

extends Node2D

const shootTime = 0.75;
#const cooldownTime = 1.5;

var timer;

var player;

var bulletScene = load("res://bullet.tscn");


func _ready():
	timer = Timer.new()
	timer.connect("timeout",_on_timer_timeout) 
	timer.set_wait_time(shootTime) #value is in seconds: 600 seconds = 10 minutes
	timer.set_one_shot(true);
	add_child(timer) 

func _on_timer_timeout():
	shoot(player);



#direction collision
func _on_area_2d_body_entered(body):
	#only happens on collision with mask 32 (the player)
	#print("there's a collision here");
	body.playerHit();

#player is in shoot range
func _on_area_2d_2_body_entered(body):
	#print("player is in shoot range");
	player = body;
	
	timer.set_wait_time(shootTime);
	timer.start();
	
	
	shoot(body);
	
func shoot(playerObj):
	$Sprite2D.play("shoot");
	var bulletNode = bulletScene.instantiate();
	add_child(bulletNode);  # add it to the current node
	
	#bulletNode.position.x = bulletNode
	#bulletNode.position.y = 
	#turns to face player
