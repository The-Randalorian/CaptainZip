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
	
	
	#body.playerHit();

func _ready():
	$editor_area.visible = false
	$AnimationPlayer.play("default")

var dead = false
var velocity = Vector2(0.0, 0.0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if dead:
		position += velocity * delta
		velocity.y += gravity * delta
	
func crabDeath():
	$Sprite2D/Area2D.set_deferred("monitoring", false)
	$Sprite2D/Area2D.set_deferred("monitorable", false)
	$AnimationPlayer.stop()
	dead = true
	velocity = Vector2(randf_range(-160, 160), -240)
