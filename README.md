# Water with Dynamic Waves in Godot
2-D Water with dynamic waves developed in Godot Engine 4.2.

## Animation Concepts and Patterns

1. Spring Modelling
- single elastic springs
- each spring is extended and held at a height positon (h)
- springs have a natural position (n) to which they are forced to return to
- the natural position (n) is positioned at a certain height, we call target height (h)
- X is the distance between target height and the postion of the a height positon the spring is extended to 
    - x descibes how much we extend the spring

2. Hooke's Law
- F = - k * x
- F: force that makes the spring return to the natural position
- k: stiffness constant of the spring 
- x: extension of the spring 

3. Hooke's Law & Velocity 
- when the Hooke's Law is applied to the Velocity vector of the spring on each frame, the spring is forced to return to the target height, but overshoots the destination of the natural position it starts to oscillate symmetrically in the vertical
- this oscillations can be used to simulate a wave

4. Loss Factor
- a Loss Factor is added to the wave to make it stop (damping)
- Loss = - d * v
- v: spring velocity
- d: spring factor (damping)

5. Spring Array
- an array of springs is needed to create a water simulation
- they need to effect their neighbours to create a fluid water animation
- eg. if one spring moves by a large amount the surrounding elements need to move in a certain fraction ...
- every spring will pull each other

## Getting Started
1. Clone or download the repository to your local machine.
2. Open the project in Godot Engine v4.2.1.
3. Navigate to the main scene and run the game.