extends Control
var displaying = true
@onready var words = $words

signal contd()


func _process(_delta):
	if displaying and Input.is_action_just_pressed("interact"):
		displaying = false # or progress!
		hide()
		contd.emit()

		
func play_dialog(text, color="white"):
	match color:
		"white":
			add_theme_color_override("font_color", Color.WHITE)
		"pink":
			add_theme_color_override("font_color", Color(245,160,151))

	show()
	displaying = true
	words.text = text

func play_dialog_timed(text, time):
	play_dialog(text)
	await get_tree().create_timer(time).timeout
	displaying = false
	hide()
	
