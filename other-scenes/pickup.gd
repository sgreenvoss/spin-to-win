extends Node2D
class_name Pickup
var r_t = 0
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@export var pickup_name = ""
signal picked_up(name)
@onready var game = $".."

func _process(delta):
	r_t += delta
	position += Vector2(0, sin(r_t)) * 0.03


func _on_area_2d_body_entered(body):
	if body.is_in_group("players"):
		picked_up.emit(pickup_name)
		queue_free()
