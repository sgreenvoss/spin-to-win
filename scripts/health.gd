extends Node2D
var health

func _ready():
	global_position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	print(global_position)
	
func initial_health(amt):
	health = amt

func new_val(amt):
	pass
