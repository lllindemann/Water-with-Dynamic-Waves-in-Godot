extends Node2D

# current force applied to the spring
var force : float = 0

# current velocity of the spring
var velocity :  float = 0

# current height of the spring
var height : float = 0

# natural position of the spring
var target_height : float = 0

# stiffness of the spring according to Hooke's Law (k)
#var k = 0.015

#dampening value of the spring
#var d = 0.03

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
#func _physics_process(delta):
	#update_water(k, d)	

func initialize(x_pos):
	position.x = x_pos
	height = position.y
	target_height = position.y
	velocity = 0
	
func update_water(stiffness_constant, dampening):
	height = position.y
	
	# spring expansion
	var x = height - target_height
	
	var loss = - dampening * velocity
	
	# Hooke's Law
	force = - stiffness_constant * x + loss
	velocity += force
	
	# movingt the spring according to its velocity
	position.y += velocity
	
