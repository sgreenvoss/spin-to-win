extends StaticBody2D
class_name Interactable
@onready var sprite_2d = $Sprite2D
var listening = false
var body

@export var orientation = "f"

func _process(_delta):
	if listening and Input.is_action_pressed("interact") and body.is_in_group("players") \
	and body.dv == orientation:
		interact()
		
	
func body_entered(_body):
	listening = true
	body = _body

func body_exited():
	listening = false
		
func interact():
	print("this should be implemented in child classes!")
