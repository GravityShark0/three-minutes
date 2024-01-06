extends Control

signal button_pressed(example)

func _input(event):
	if event.is_action_pressed("upgrademenu"):
		visible = not visible


func _on_example_button_pressed():
	button_pressed.emit('shiteass')



## When making a new node always use this signal name
func _on_upgrade(id):
	pass # Replace with function body.
