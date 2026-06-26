extends Interactable
@onready var blocking_collider = $blocking_collider
@onready var collision_shape_2d = $interactable_area/CollisionShape2D
@onready var game = $"../.."
@export var locked = false

signal opened()

func interact():
	if locked:
		if !game.open_key:
			game.tooltip.play_dialog_timed("no key!", 3)
			# play a locked noise
			return
		else:
			game.open_key = false # to reuse key. wow this is bad programming but im crunching who gaf
			pass
	sprite_2d.visible = false
	collision_shape_2d.disabled = true
	blocking_collider.disabled = true
	opened.emit()

func _on_area_2d_body_entered(body):
	super.body_entered(body)

func _on_area_2d_body_exited(body):
	super.body_exited()
