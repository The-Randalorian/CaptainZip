extends Label
var start_time;

# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = Time.get_ticks_usec() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var total_seconds = (Time.get_ticks_usec() - start_time) * 0.000001
	var minutes = floor(total_seconds / 60)
	var seconds = total_seconds - (minutes * 60)
	var time_string = ("%02d" % minutes) + ":" + ("%02.3f" % seconds)
	self.text = time_string
	print(self.position)
