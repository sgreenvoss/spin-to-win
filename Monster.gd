extends CharacterBody2D
class_name Monster

@onready var animated_sprite_2d = $AnimatedSprite2D
const obj_bullet = preload("res://other-scenes/bullet.tscn")
# might store this somwhere else
# shoutout https://www.youtube.com/watch?v=Z2TaFnN7cdU&t=152s
var noise = FastNoiseLite.new()
const rotate_speed = 100 # this and below go unused here, for inherited classes
const spawn_point_count = 4
const radius = 15

var health = 2
var shoot_delay = 0.1
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

func _physics_process(delta):
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
	
func shoot_dir(ct):
	var choice = ct % 4
	var direction

	match choice:
		0:
			direction = Vector2.RIGHT
		1:
			direction = Vector2.DOWN
		2:
			direction = Vector2.LEFT
		3: 
			direction = Vector2.UP

	return direction

func shoot():
	var new_bullet = obj_bullet.instantiate()
	counter += 1
	var direction = shoot_dir(counter)
	new_bullet.speed = bullet_speed
	new_bullet.rotation = direction.angle()
	new_bullet.position = transform.get_origin() + direction * radius
	get_parent().add_child(new_bullet)
	
func take_damage(amt: int):
	health -= amt
	 # below isn't setting to pink but is setting to white so i think thats fine
	animated_sprite_2d.material.set_shader_parameter("solid_color", PINK)
	play_dmg()
	if health <= 0:
		queue_free()

func play_dmg():
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.material.set_shader_parameter("solid_color", Vector4.ZERO)
