extends Node
# feb is gonna cook here he doesnt know what to cook yet
# Called when the node enters the scene tree for the first time.
signal back_from_credits

func _input(event):
	if Input.is_action_just_pressed("burger"):
		$burger.visible = not $burger.visible


func _on_leave_button_up():
	back_from_credits.emit()
