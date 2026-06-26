extends Sprite2D
var dt = 0

func _process(delta):
	dt += delta
	scale += Vector2(sin(dt), sin(dt)) * 0.001
