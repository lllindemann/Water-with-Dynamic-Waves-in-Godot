extends Node2D

# spring factor
@export var k = 0.015
# dampening factor
@export var d = 0.03

# factor to which springs will spread to their neighbours (waves)
@export var spread = 0.0002

#spring array
var springs = []

# how often the process is repeated every frame
var passes = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	# fill springs array with all child springs
	for s in get_children():
		#if s.get_class() == "":
		springs.append(s)
		s.initialize()
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
	
