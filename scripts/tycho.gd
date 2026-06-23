extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

var dv = "f"
var health = 10
signal damaged(past_health, current_health)
signal dead()

const PINK = Vector4(232, 106, 115, 256)

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.length() == 0:
		walk_anim(dv)
	elif direction == Vector2.UP:
		walk_anim("walk-b")
		dv = "b"
	elif direction == Vector2.DOWN:
		walk_anim("walk-f")
		dv = "f"
	elif direction == Vector2.LEFT:
		walk_anim("walk-l")
		dv = "l"
	elif direction == Vector2.RIGHT:
		walk_anim("walk-r")
		dv = "r"
		
	velocity = direction.normalized() * 200
	move_and_slide()

func take_damage(amount: int):
	animated_sprite_2d.material.set_shader_parameter("solid_color", PINK)
	play_dmg()
	var past_health = health
	health -= amount
	if health >= 0:
		damaged.emit(past_health, health)
	else:
		dead.emit()
	

func walk_anim(animation: String):
	animated_sprite_2d.play(animation)
	
func play_dmg():
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.material.set_shader_parameter("solid_color", Vector4.ZERO)
