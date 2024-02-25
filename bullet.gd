extends CharacterBody2D

const bulletVelocity = -300;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	velocity.x = bulletVelocity;
	move_and_slide();
