extends Node


func _ready():
	pass

#menu button / play
func _on_play_button_up():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_leave_button_up():
	get_tree().quit()


func _on_credits_button_up():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
