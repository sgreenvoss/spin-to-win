extends Node
class_name GameManager
@onready var pause_menu = $Control/PauseMenu
@onready var dialog_box = $Control/DialogBox
@onready var panel = $Control/panel
@onready var heart = $Control/heart
@onready var tooltip = $Control/tooltip
@onready var money_text = $Control/money
@onready var mt_words = $Control/money/words

var money = 0
var paused = false
@onready var character = $Control/panel/character
var PINK = Color(245,160,151)
var open_key = false
var boss_key = false

func _ready():
	play_intro()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func play_scene(_panel, words):
	panel.display_panel(_panel)
	dialog_box.play_dialog(words)
	await dialog_box.contd
	return
		
func play_intro():
	money_text.hide()
	if StateSaver.played_intro == true:
		leaveCutscene()
		return
	paused = true
	#Engine.time_scale = 0
	await play_scene("DARK",
					 "How could it have gone so wrong?")
	await play_scene("CONF_1",
					 "You can't think of a single moment where you blew your cover. Your infiltration of the ghost office was impeccable, your disguise imperceptible."
	)
	await play_scene("CONF_2",
					 "Somehow, those ingenious ghosts figured you out. You'll never know what tipped them off.")
					
	await play_scene("DARK",
					 "An attempt at escape has left you stranded in a dank maintenance room, bullets beating against the too-thin door."
	)
	await play_dialog("You're safe. But for how long? You don't even have a weapon!")
	character.show()
	await play_dialog("[color=PINK]Don't worry, you'll get out of this okay![/color]")
	
	leaveCutscene()
	character.hide()

func leaveCutscene():
	money_text.show()
	panel.hide()
	paused = false
	heart.show()
	Engine.time_scale = 1


func pauseMenu():
	panel.display_panel("CONF_2")
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
	
func play_dialog(text):
	dialog_box.play_dialog(text)
	await dialog_box.contd
	return

func _on_tycho_dead():
	heart.hide()
	Engine.time_scale = 0
	panel.display_panel("DEAD", true)


func _on_try_again_pressed():
	StateSaver.played_intro = true
	get_tree().reload_current_scene()


func _on_give_up_pressed():
	get_tree().quit()


func _on_dialog_box_contd():
	pass # Replace with function body.


func on_pickup_collected(name):
	match name:
		"key":
			open_key = true
		"$100":
			money += 100
			mt_words.text = "$%s" %money
	tooltip.play_dialog_timed("+ %s" %name, 3)


func _on_money_picked_up(_name):
	money += 100
	mt_words.text = "$%s" %money
