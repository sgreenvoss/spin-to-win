extends Control
@onready var graphic = $graphic
const DARK = preload("res://sprites/dark.png")
const DEAD = preload("res://sprites/dead.png")
const CONF_1 = preload("res://sprites/conf_table.png")
const CONF_2 = preload("res://sprites/conf_table_meow.png")

@onready var buttons = $buttons

var lut = {
	"DARK": DARK,
	"DEAD": DEAD,
	"CONF_1": CONF_1,
	"CONF_2": CONF_2
}

func toggle_buttons():
	buttons.show()

func display_panel(panel_name, toggle=false):
	graphic.texture = lut[panel_name]
	if toggle:
		toggle_buttons()
	show()
	
func hide_panel():
	hide()
