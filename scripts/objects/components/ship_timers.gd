extends Node

# @export_range(0.05, 100) var primary_cooldown: float
signal primary_timeout
signal special_timeout
signal dash_timeout
signal dash_cooldown_timeout
signal hit_lag_timeout


func _on_primary_timer_2_timeout():
	primary_timeout.emit()


func _on_special_timeout():
	special_timeout.emit()


func _on_dash_cool_timeout():
	dash_cooldown_timeout.emit()


func _on_dash_length_timeout():
	dash_timeout.emit()


func _on_hit_lag_timeout():
	hit_lag_timeout.emit()
