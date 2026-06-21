extends Interactable
@onready var blocking_collider = $blocking_collider
@onready var collision_shape_2d = $interactable_area/CollisionShape2D

func interact():
	sprite_2d.visible = false
	collision_shape_2d.disabled = true
	blocking_collider.disabled = true

func _on_area_2d_body_entered(body):
	super.body_entered(body)

func _on_area_2d_body_exited(body):
	super.body_exited()
