extends Node2D

# current force applied to the spring
var force : float = 0

# current velocity of the spring
var velocity :  float = 0

# current height of the spring
var height : float = position.y

# natural position of the spring
var target_height : float = position.y + 80

# stiffness of the spring according to Hooke's Law (k)
var k = 0.015

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _physics_process(delta):
	update_water(k)	

func update_water(stiffness_constant):
	height = position.y
	
	# spring expansion
	var x = height - target_height
	
	# Hooke's Law
	force = - stiffness_constant * x
	velocity += force
	
	# movingt the spring according to its velocity
	position.y += velocity
	
