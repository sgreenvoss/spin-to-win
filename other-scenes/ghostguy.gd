extends Monster
@onready var rotator = $Rotator
const BULLET = preload("res://other-scenes/bullet.tscn")

func _ready():
	super._ready()
	var step = 2 * PI / spawn_point_count
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * 1)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

func _process(delta):
	var new_rotation = rotator.rotation_degrees + rotate_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)
		
func shoot():
	for s in rotator.get_children():
		var bullet = BULLET.instantiate()
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
		bullet.speed = bullet_speed
		get_tree().root.add_child(bullet)
		
