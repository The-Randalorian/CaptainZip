@tool

class_name Zipline

extends Node2D

const SEGMENT_SIZE = 6

@export var endpoint = Vector2(2, 0):
	set(new_endpoint):
		endpoint = new_endpoint
		rebuild()

@export var template: PackedScene:
	set(new_template):
		template = new_template
		rebuild()
		
@export var drop = 0.1:
	set(new_drop):
		drop = new_drop
		rebuild()
		
@export var start_head: PackedScene:
	set(new_start_head):
		start_head = new_start_head
		rebuild()
		
@export var end_head: PackedScene:
	set(new_end_head):
		end_head = new_end_head
		rebuild()

@export var is_level_end = false

var components = []
var a = 0.0
var p = 0.0
var q = 0.0
#var is_ready = false

func _ready():
	#is_ready = true
	rebuild()

func attach_body(body):
	#print("Body attached!")
	body.attach_to_zip(self)
	if is_level_end:
		get_tree().reload_current_scene()

func rebuild():
	if template == null:
		return
	#print(">>>>>>>>>>", endpoint, template, drop)
	#if not is_ready:
	#	return
	
	for component in components:
		component.queue_free()
	components = []
	_bake_catenary()
	var ratio = endpoint.x / (floor(endpoint.x / SEGMENT_SIZE) * SEGMENT_SIZE)
	while len(components) < round(endpoint.x) / SEGMENT_SIZE:
		var component = template.instantiate()
		component.name = "bridge_component_" + str(len(components))
		var distance = ratio * len(components) * SEGMENT_SIZE
		var height = -1 * calculate_catenary(distance)
		var delta = -1 * calculate_catenary(distance + ratio) - height
		#print(distance, ", ", height, ", ", ratio)
		component.position = Vector2(
			distance, 
			height)
		var shift = Vector2(ratio, delta)
		component.scale = Vector2(shift.length(), 1.0)
		component.rotation = shift.angle()
		component.skew = -shift.angle()
		components.append(component)
		add_child(component)
		component.body_entered.connect(attach_body)
	
	if start_head != null:
		var start = start_head.instantiate()
		start.name = "bridge_start"
		start.position = Vector2(-1, 0)	
		components.append(start)
		add_child(start)
	
	if end_head != null:
		var end = end_head.instantiate()
		end.name = "bridge_end"
		end.position = endpoint + Vector3(1, 0, 0)
		end.scale = Vector3(-1, 1, 1)
		components.append(end)
		add_child(end)
	
func calculate_catenary(distance):
	#print(a)
	return a * cosh((distance-p)/a) + q

func get_snap_height(x):
	return position.y - calculate_catenary(x - position.x)

const DERIVATIVE_STEP = 0.001

func get_snap_slope(x):
	var center = x - position.x
	var rise = calculate_catenary(center + DERIVATIVE_STEP) - calculate_catenary(center - DERIVATIVE_STEP)
	var run = DERIVATIVE_STEP + DERIVATIVE_STEP
	return rise / run

func get_snap_slope_vector(x):
	return Vector2(1.0, get_snap_slope(x)).normalized()

func _bake_catenary():
	var h = endpoint.x
	var v = endpoint.y
	var l = Vector2(endpoint.x, endpoint.y).length() + drop
	a = (l * l * l)  # calculate a really big upper boud to bisect with.
	
	var Precision = 0.00001;
	#var IntervalStep = 0.01
	
	var a_prev = 0.0#a - IntervalStep
	var a_next = a
	var loop_count = 0
	#print("baking... ", loop_count, ", ", a)
	while loop_count <= 0 or a_next - a_prev > Precision:
		loop_count += 1
		a = (a_prev + a_next) / 2.0;
		if (sqrt(pow(l, 2) - pow(v, 2)) < 2 * a * sinh(h/(2*a))):
			a_prev = a
		else:
			a_next = a
			
		#print("baking... ", loop_count, ", ", a)
		if loop_count > 1000:
			return
	
	p = (h - a * log((l+v)/(l-v))) / 2
	q = (v - l / tanh(h/(2*a))) / 2
