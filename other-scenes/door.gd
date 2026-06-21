extends Area2D
@onready var collision_shape_2d = $CollisionShape2D
@export var orientation = "s"

func _on_body_entered(body):
	if Input.is_action_pressed("interact") and body.is_in_group("players") \
		and body.dv == orientation:
		interact()
		
func interact():
	pass
