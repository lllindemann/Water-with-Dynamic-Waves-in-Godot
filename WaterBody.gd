extends Node2D

# spring factor
@export var k = 0.015
# dampening factor
@export var d = 0.03

# factor to which springs will spread to their neighbours (waves)
@export var spread = 0.0002

# depth of the water body
@export var depth = 1000

# thickness of water_border (of smoothing path)
@export var border_thickness: float = 1.1

# distance in pixels between each spring
@export var distance_between_springs =  100
# number of springs for the water animation in the scene
@export var number_of_springs = 10

# total length of the water body
var water_length = distance_between_springs * number_of_springs

#spring array
var springs = []

# water depth calculation for water polygon
var target_height = global_position.y
var bottom = target_height + depth

# how often the process is repeated every frame
var passes = 10

@onready var water_spring = preload("res://WaterSpring.tscn")
@onready var water_polygon= $WaterPolygon
@onready var water_border = $SmoothPath

# Called when the node enters the scene tree for the first time.
func _ready():
	#water_border.width = border_thickness
	# fill springs array with all child springs
	for s in range(number_of_springs):
		var x_pos = distance_between_springs * s
		var instance = water_spring.instantiate()
		add_child(instance)
		springs.append(instance)
		instance.initialize(x_pos)
	splash(4,25)


func _physics_process(delta):
	for s in springs:
		s.update_water(k,d)
	
	# stores differences in height between each spring [s] and its left neighbour [s -1] 
	var left_deltas = []
	# stores differences in height between each spring [s] and its right neighbour [s + 1] 
	var right_deltas = []
	
	for s in range (springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		pass
	
	for p in range (passes):
		for s in range (springs.size()):
			if s >0:
				left_deltas[s] = spread * (springs[s].height - springs[s -1].height)
				springs[s -1].velocity +=  left_deltas[s]
			if s < springs.size() - 1:
				right_deltas[s] = spread * (springs[s].height - springs[s +1].height)
				springs[s +1].velocity +=  left_deltas[s]
				
	draw_water_body()
	new_border()

# adds speed to a spring whith the index	
func draw_water_body():
	# positions of springs
	var surface_points = []
	
	for s in range(springs.size()):
		surface_points.append(springs[s].position)
		
	var first_index = 0
	var last_index = surface_points.size() -1 
	
	var water_polygon_points = surface_points
	# points to close the polygon at the bottom
	water_polygon_points.append(Vector2(surface_points[last_index].x, bottom))
	water_polygon_points.append(Vector2(surface_points[first_index].x, bottom))
	
	water_polygon_points = PackedVector2Array(water_polygon_points)
	water_polygon.polygon = water_polygon_points

func new_border():
	# draw new border on the water
	# create curve 2D
	water_border.curve = Curve2D.new()
	#water_border.curve.clear_points()
	var surface_points = []
	for s in range(springs.size()):
		water_border.curve.add_point(springs[s].position)
		
	#water_border.curve = curve
	water_border._smooth = true
	water_border.queue_redraw()
	pass
			
# adds speed to a spring whith the index	
func splash(index, speed):
	if index > 0 and index < springs.size():
		springs[index].velocity += speed
	
