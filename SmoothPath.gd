# author: Dlean Jeans
# source: https://forum.godotengine.org/t/how-to-draw-a-curve-in-2d/26469/4
# modified for Godot 4 support by Leonie Lindemann
@tool
class_name SmoothPath
extends Path2D

@export var spline_length : float = 100
@export var _smooth : bool = true:
	get:
		return _smooth
	set(value):
		if not value: return
		var point_count = curve.get_point_count()
		for i in point_count:
			var spline = _get_spline(i)
			curve.set_point_in(i, -spline)
			curve.set_point_out(i, spline)
	
@export var _straighten : bool:
	get:
		return _straighten
	set(value):
		if not value: return
		for i in curve.get_point_count():
			curve.set_point_in(i, Vector2())
			curve.set_point_out(i, Vector2())

func _get_spline(i):
	var last_point = _get_point(i - 1)
	var next_point = _get_point(i + 1)
	var spline = last_point.direction_to(next_point) * spline_length
	return spline

func _get_point(i):
	var point_count = curve.get_point_count()
	i = wrapi(i, 0, point_count)
	return curve.get_point_position(i)

func _draw():
	var points = curve.get_baked_points()
	if points:
		draw_polyline(points, Color.WHITE, 1, true)
	
