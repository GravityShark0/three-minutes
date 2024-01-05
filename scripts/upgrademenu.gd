extends Control
func _physics_process(delta):
	if Input.is_action_just_released("upgrademenu"):
		visible = true
	if Input.is_action_just_released("upgrademenuclose"):
		visible = false
