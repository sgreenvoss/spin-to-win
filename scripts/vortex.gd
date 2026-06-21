extends Node2D
var mousepos
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
var rotation_speed = 0.05
var vortex_duration = 1.0
var vortex_delay = 1.0
var time_since_v = 0.0 
var vortexing = false
var in_vortex = 0.0 # counts the time spent in the vortex

func _process(delta):
	if vortexing:
		vortex(delta)
	else:
		mousepos = get_global_mouse_position()
		position = mousepos
		time_since_v += delta
		if time_since_v > vortex_delay:
			animated_sprite_2d.play("default")
			
			if Input.is_action_pressed("vortex"):
				animated_sprite_2d.play("vortex")
				in_vortex = 0
				vortexing = true
				vortex(delta)

func vortex(delta):
	in_vortex += delta
	var objs = area_2d.get_overlapping_areas()
	for body in objs:
		if body.is_in_group("bullet"):
			body.relax()
			var offset = body.global_position - global_position
			offset = offset.rotated(body.spin_dir * rotation_speed)
			body.global_position = global_position + offset
			body.rotation += rotation_speed * body.spin_dir
			
	if in_vortex > vortex_duration or Input.is_action_just_released("vortex"):
		animated_sprite_2d.play("out")
		vortexing = false
		time_since_v = 0
		for body in objs:
			if body.is_in_group("bullet"):
				body.unrelax()
