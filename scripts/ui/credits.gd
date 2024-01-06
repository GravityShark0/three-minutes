extends Node
# feb is gonna cook here he doesnt know what to cook yet
# Called when the node enters the scene tree for the first time.

func _input(event):
	if Input.is_action_just_pressed("burger"):
		$burger.visible = not $burger.visible


func _on_leave_button_up():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
