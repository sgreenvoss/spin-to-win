extends TextureRect

# this is stupid!
const HEART_0 = preload("res://sprites/hearts/heart_0.png")
const HEART_1 = preload("res://sprites/hearts/heart_1.png")
const HEART_2 = preload("res://sprites/hearts/heart_2.png")
const HEART_3 = preload("res://sprites/hearts/heart_3.png")
const HEART_4 = preload("res://sprites/hearts/heart_4.png")
const HEART_5 = preload("res://sprites/hearts/heart_5.png")
const HEART_6 = preload("res://sprites/hearts/heart_6.png")
const HEART_7 = preload("res://sprites/hearts/heart_7.png")
const HEART_8 = preload("res://sprites/hearts/heart_8.png")
const HEART_9 = preload("res://sprites/hearts/heart_9.png")
const HEART_10 = preload("res://sprites/hearts/heart_10.png")
const HEART_11 = preload("res://sprites/hearts/heart_11.png")
var diff = 0
var current_index = 0

var heart_arr = [
	HEART_0,
	HEART_1,
	HEART_2,
	HEART_3,
	HEART_4,
	HEART_5,
	HEART_6,
	HEART_7,
	HEART_8,
	HEART_9,
	HEART_10,
	HEART_11
]

const tycho_max_health = 10 # i dont know if this will change, if it does
								# grab from tycho instead

func _ready():
	set_texture(heart_arr[current_index])

func _on_tycho_damaged(past_health, current_health):
	var diff = past_health - current_health
	current_index += diff
	set_texture(heart_arr[current_index])
