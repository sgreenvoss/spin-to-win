extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

var dv = "f"
var health = 10
signal damaged(current_health)

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
	health -= amount
	damaged.emit(health)

func walk_anim(animation: String):
	animated_sprite_2d.play(animation)
	
