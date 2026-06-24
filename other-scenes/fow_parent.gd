extends Control

func reveal():
	for child in get_children():
		child.hide()
