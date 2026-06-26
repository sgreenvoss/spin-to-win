extends Node
class_name GameManager
@onready var pause_menu = $Control/PauseMenu
@onready var dialog_box = $Control/DialogBox
@onready var panel = $Control/panel
@onready var heart = $Control/heart
@onready var tooltip = $Control/tooltip
@onready var money_text = $Control/money
@onready var mt_words = $Control/money/words
@onready var character = $Control/panel/character
@onready var character_2 = $Control/panel/character2

var money = 0
var paused = false
var PINK = Color(245,160,151)
var open_key = false
var boss_key = false
var moving_chars = false
var GRAY = Color(109,117,141)
var MY_BLUE = Color(36,159,255)

func _ready():
	character.global_position = Vector2(525, 273)
	character_2.global_position = Vector2(1425, 1203)
	character.hide()
	character_2.hide()
	play_intro()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
	if moving_chars:
		character.global_position = character.global_position.lerp(Vector2(288,273), delta * 0.5)
		character_2.global_position = character.global_position.lerp(Vector2(1425,656), delta * 0.5)


func play_scene(_panel, words):
	panel.display_panel(_panel)
	dialog_box.play_dialog(words)
	await dialog_box.contd
	return
		
func play_intro():
	money_text.hide()
	var anim = character_2.get_child(0)
	anim.set_animation("default")
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
	character_2.show()
	await play_dialog("[color=PINK]Don't worry, you'll get out of this okay![/color]")
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(character, "global_position", Vector2(288,273), 0.65)
	tween.parallel().tween_property(character_2, "global_position", Vector2(1425,656), 0.65)
	await tween.finished
	await play_scene("DARK", "")
	
	anim.set_animation("talk")
	await char_say("... What?", "r")
	anim.set_animation("default")
	
	await char_say("[color=PINK]Greetings, cat! I am the 1186435 3/4HP ECM Blower Motor. I help control the airflow in the ghost office![/color]", "l")
	await char_say("[color=PINK]Every second or so, I can make a little vortex that turns their bullets around! When bullets are in sight, point to where you'd like them to start spinning.[/color]", "l")
	await char_say("[color=PINK]Watch out, though. [color=GRAY]Some bullets[/color] might be too heavy to spin.", "l")

	anim.set_animation("talk")
	await char_say("... Why are you helping me?", "r")
	anim.set_animation("default")
	
	await char_say("[color=PINK]I'm scared of ghosts :([/color]", "l")

	anim.set_animation("talk")
	await char_say("Right.", "r")
	anim.set_animation("default")

	
	anim.set_animation("talk")
	await char_say("Thank you. I will try my best.", "r")
	anim.set_animation("default")
	
	tween = create_tween()
	tween.tween_property(character, "global_position", Vector2(-300,273), 0.65)
	tween.parallel().tween_property(character_2, "global_position", Vector2(1125,656), 0.65)
	await tween.finished
	
	anim.set_animation("talk")
	await play_dialog("Okay. I need to find and incapacitate the boss to take his important business documents. I should also try to take as much money as I can.")
	anim.set_animation("default")

	leaveCutscene()
	character.hide()
	character_2.hide()

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

func char_say(text, char):
	dialog_box.char_say(text, char)
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
