#@Authors - Patrick
#@Description - cowboy actions

extends Node2D

const shootTime = 0.75;

var canShoot = false;

var timer;

var player;



func _physics_process(delta):
	if (canShoot):
		shoot(player);

func _ready():
	timer = Timer.new()
	timer.connect("timeodut",_on_timer_timeout) 
	timer.set_wait_time(shootTime) #value is in seconds: 600 seconds = 10 minutes
	timer.set_one_shot(true);
	add_child(timer) 

func _on_timer_timeout():
	canShoot = true;



#direction collision
func _on_area_2d_body_entered(body):
	#only happens on collision with mask 32 (the player)
	#print("there's a collision here");
	body.playerHit();

#player is in shoot range
func _on_area_2d_2_body_entered(body):
	#print("player is in shoot range");
	canShoot = true;
	player = body;
	
	timer.set_wait_time(shootTime);
	timer.start();
	
	
	shoot(body);
	
func shoot(playerObj):
	$Sprite2D.play("shoot");
	#turns to face player
	canShoot = false;
