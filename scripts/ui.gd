extends CanvasLayer


func _process(_delta):
	$TimeRemaining.text = ("%10.4f" % %TaskTime.time_left + " Seconds left")
	$Health.value = %Player.get("player_health")
	$DashCooldown.value = %Player/Timers/DashCooldown.get_time_left()
