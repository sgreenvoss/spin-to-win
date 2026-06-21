extends Monster
class_name Blinky_guy

#func _ready():
	#animated_sprite_2d.play("blonk")
	#noise.seed = randi()
	#noise.frequency = 0.05
	#noise.noise_type = FastNoiseLite.TYPE_PERLIN
#
#func _physics_process(delta):
	## this guy is gonna move with perlin noise i think
	#t += delta * 10
	#shoot_timer += delta
	#if shoot_timer >= shoot_delay:
		#shoot()
		#shoot_timer = 0
	#var directionx = noise.get_noise_1d(t)
	#var directiony = noise.get_noise_1d(t + 1000)
	##print(directionx, directiony)
	#velocity = Vector2(directionx, directiony).normalized() * 10
	#move_and_slide()
	#
#func shoot_dir(ct):
	#var choice = ct % 4
	#var direction
#
	#match choice:
		#0:
			#direction = Vector2.RIGHT
		#1:
			#direction = Vector2.DOWN
		#2:
			#direction = Vector2.LEFT
		#3: 
			#direction = Vector2.UP
#
	#return direction
#
#func shoot():
	#var new_bullet = obj_bullet.instantiate()
	#var speed = 50
	#counter += 1
	#var direction = shoot_dir(counter)
	#new_bullet.speed = speed
	#new_bullet.rotation = direction.angle()
	##direction*15 because of its own hitbox
	#new_bullet.position = transform.get_origin() + direction * 15
	#get_parent().add_child(new_bullet)
	#
#func take_damage(amt: int):
	#health -= amt
	 ##play dmg anim?
	#animated_sprite_2d.material.set_shader_parameter("solid_color", PINK)
	#play_dmg()
	#if health <= 0:
		#queue_free()
#
#func play_dmg():
	#await get_tree().create_timer(0.1).timeout
	#animated_sprite_2d.material.set_shader_parameter("solid_color", Vector4.ZERO)
