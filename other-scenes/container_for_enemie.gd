extends Node

func show_creatures():
	for child in get_children():
		child.show()
