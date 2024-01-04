extends CanvasLayer


func _process(_delta):
	$TimeRemaining.text = ("%1.4f" % %TaskTime.time_left + " Seconds left")
	$Health.value = %Player.get("player_health")
	$DashCooldown.value = %Player/ShipTimers/DashCool.get_time_left()
