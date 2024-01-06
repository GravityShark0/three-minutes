extends Node


#menu button / play
func _on_play_button_up():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_leave_button_up():
	get_tree().quit()


func _on_credits_button_up():
	$MainMenu.visible = false
	$Credits.visible = true


func _on_credits_back_from_credits():
	$MainMenu.visible = true
	$Credits.visible = false
