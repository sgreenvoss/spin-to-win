extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("splode")
	await animated_sprite_2d.animation_finished
	
	queue_free()
