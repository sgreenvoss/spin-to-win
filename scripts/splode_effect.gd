extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var explosion

func _ready():
	animated_sprite_2d.play(explosion)
	await animated_sprite_2d.animation_finished
	
	queue_free()
