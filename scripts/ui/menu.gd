extends Node


func _ready(): #just cooked osmething
	var current_scene = get_tree().get_current_scene()
	if current_scene.get_name() == "Menu":
		$Theme.play()

#menu button / play
func _on_play_button_up():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_leave_button_up():
	get_tree().quit()


func _on_credits_button_up():
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")
