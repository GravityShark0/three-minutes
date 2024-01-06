extends Node

#febs cooking place cause he doesnt knwo where ot cook anymore

signal back_from_settings
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_leave_button_up():
	back_from_settings.emit()
