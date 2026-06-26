extends Control
var displaying = true
@onready var words = $words

signal contd()


func _process(_delta):
	if displaying and Input.is_action_just_pressed("interact"):
		displaying = false # or progress!
		hide()
		contd.emit()

		
func play_dialog(text):
	show()
	displaying = true
	words.text = text
