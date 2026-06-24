extends Node
@onready var creatures = $Creatures
@onready var fow =$fow

func _ready():
	$Door.opened.connect(_on_door_opened)
	$fow.show()

func _on_door_opened():
	creatures.show_creatures()
	fow.reveal()
