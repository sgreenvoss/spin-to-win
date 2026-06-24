extends CharacterBody2D
class_name Monster

@onready var rotator = $Rotator
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var bullet_type = preload("res://other-scenes/bullet.tscn")
@export var spawn_point_count = 4
@export var shoot_delay = 0.1
const SplodeEffect = preload("res://other-scenes/splode_effect.tscn")
# might store this somwhere else
# shoutout https://www.youtube.com/watch?v=Z2TaFnN7cdU&t=152s
var noise = FastNoiseLite.new()
var rotate_speed = 100 
var radius = 15

var health = 2
var shoot_timer = 0.0
var t = 0.0
var counter = 0
const PINK = Vector4(232, 106, 115, 256)

var bullet_speed = 50

func _ready():
	animated_sprite_2d.play("default")
	noise.seed = randi()
	noise.frequency = 0.05
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	
	# set up spawners
	var step = 2.0 * PI / float(spawn_point_count)
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

func _physics_process(delta):
	if not visible:
		return
	var new_rotation = rotator.rotation_degrees + rotate_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)
	# this guy is gonna move with perlin noise i think
	t += delta * 10
	shoot_timer += delta
	if shoot_timer >= shoot_delay:
		shoot()
		shoot_timer = 0
	var directionx = noise.get_noise_1d(t)
	var directiony = noise.get_noise_1d(t + 1000)
	#print(directionx, directiony)
	velocity = Vector2(directionx, directiony).normalized() * 10
	move_and_slide()
	


func shoot():
	for s in rotator.get_children():
		var bullet = bullet_type.instantiate()
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
		bullet.speed = bullet_speed
		get_tree().root.add_child(bullet)
		
	
func take_damage(amt: int):
	health -= amt
	 # below isn't setting to pink but is setting to white so i think thats fine
	animated_sprite_2d.material.set_shader_parameter("solid_color", PINK)
	play_dmg()
	if health <= 0:
		var splosion = SplodeEffect.instantiate()
		splosion.position = position
		splosion.explosion = "deltarune"
		get_parent().add_child(splosion)
		queue_free()

func play_dmg():
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.material.set_shader_parameter("solid_color", Vector4.ZERO)
