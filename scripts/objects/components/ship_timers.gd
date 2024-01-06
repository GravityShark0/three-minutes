extends Node

## Seconds before a ship can fire its primary again
@export_range(0.001,4096,0.001,"or_greater","exp","suffix:s") var primary_cooldown: float = 0.5

## Seconds before a ship can fire its special again
@export_range(0.001,4096,0.001,"or_greater","exp","suffix:s") var special_cooldown: float = 1.0

## Seconds before a ship can dash again
@export_range(0.001,4096,0.001,"or_greater","exp","suffix:s") var dash_cooldown: float = 0.8

## Seconds for how long a dash can
@export_range(0.001,4096,0.001,"or_greater","exp","suffix:s") var dash_length: float = 0.2

## Seconds for how long hit lag should last
@export_range(0.001,4096,0.001,"or_greater","exp","suffix:s") var hit_lag: float = 0.1
	
signal primary_timeout
signal special_timeout
signal dash_cooldown_timeout
signal dash_timeout
signal hit_lag_timeout

func _ready():
	$Primary.wait_time = primary_cooldown
	$Special.wait_time = special_cooldown
	$DashCooldown.wait_time = dash_cooldown
	$DashLength.wait_time = dash_length
	$HitLag.wait_time = hit_lag

func _on_primary_timer_2_timeout():
	primary_timeout.emit()
func _on_special_timeout():
	special_timeout.emit()
func _on_dash_cooldown_timeout():
	dash_cooldown_timeout.emit()
func _on_dash_length_timeout():
	dash_timeout.emit()
func _on_hit_lag_timeout():
	hit_lag_timeout.emit()
