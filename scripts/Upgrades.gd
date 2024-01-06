extends Node

var watch_my_dict: Dictionary
var index = 0


func _on_upgrade_button_pressed(example):
	index += 1
	watch_my_dict[index] = example
	
	print(watch_my_dict)
