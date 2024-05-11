extends Node2D

# spring factor
@export var k = 0.015
# dampening factor
@export var d = 0.03

# factor to which springs will spread to their neighbours (waves)
@export var spread = 0.0002

# distance in pixels between each spring
@export var distance_between_springs = 65
# number of springs for the water animation in the scene
@export var number_of_springs = 10

# total length of the water body
var water_length = distance_between_springs * number_of_springs

#spring array
var springs = []
# how often the process is repeated every frame
var passes = 8

@onready var water_spring = preload("res://WaterSpring.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# fill springs array with all child springs
	for s in range(number_of_springs):
		var x_pos = distance_between_springs * s
		var instance = water_spring.instantiate()
		add_child(instance)
		springs.append(instance)
		instance.initialize(x_pos)
	splash(2,5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
			pass

# adds speed to a spring whith the index	
func splash(index, speed):
	if index > 0 and index < springs.size():
		springs[index].velocity += speed
	
