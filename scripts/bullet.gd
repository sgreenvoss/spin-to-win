extends Area2D
class_name Bullet
const obj_splode = preload("res://other-scenes/splode_effect.tscn")

var speed
var duration = 20
var relaxed: bool = false
var velocity
var explosion_name

func make_new_vel():
	velocity = speed * Vector2.from_angle(rotation)

func _ready() -> void:
	explosion_name = "pink"
	connect("body_entered", _on_body_entered)
	make_new_vel()
	
func _process(delta) -> void:
	if not relaxed:
		position += velocity * delta
		duration -= delta
	if duration < 0:
		queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("living"):
		body.take_damage(1)
		
	draw_explosion()
	queue_free()
		
func draw_explosion():
	var splosion = obj_splode.instantiate()
	splosion.explosion = explosion_name
	splosion.position = position
	get_parent().add_child(splosion)
	
func relax():
	relaxed = true
func unrelax():
	relaxed = false
	make_new_vel()
