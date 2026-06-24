extends Control
var displaying = true
@onready var words = $words


func _process(_delta):
	if displaying and Input.is_action_pressed("interact"):
		displaying = false # or progress!
		hide()
		
func play_dialog(text):
	displaying = true
	words.text = text
	show()
