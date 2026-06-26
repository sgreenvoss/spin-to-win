extends Control
var displaying = true
@onready var words = $words
@onready var word_arr = $word_arr

signal contd()

func _ready():
	hide()

func _process(_delta):
	if displaying and Input.is_action_just_pressed("interact"):
		displaying = false # or progress!
		hide()
		word_arr.hide()
		contd.emit()

		
func play_dialog(text):
	show()
	displaying = true
	words.text = text

func char_say(text, character):
	match character:
		"l":
			word_arr.global_position.x = 472
			word_arr.scale.x = -1
		"r":
			word_arr.global_position.x = 628
			word_arr.scale.x = 1
	word_arr.show()
	play_dialog(text)

func play_dialog_timed(text, time):
	play_dialog(text)
	await get_tree().create_timer(time).timeout
	displaying = false
	hide()
	
