extends Node2D

signal after_explode

func _on_explode_finished():
	after_explode.emit()
	
