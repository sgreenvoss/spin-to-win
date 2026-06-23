extends Node
@onready var pause_menu = $Control/PauseMenu
var paused = false
#@onready var health_bar = $CanvasLayer/health

#
#func _ready():
	#var tycho = get_node("Tycho")
	#var health = tycho.health
	#tycho.damaged.connect(_on_damaged)
	#health_bar.initial_health(health)
	#
#func _on_damaged(amt):
	#health_bar.new_val(amt)
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

func _on_tycho_dead():
	pass # Replace with function body.
