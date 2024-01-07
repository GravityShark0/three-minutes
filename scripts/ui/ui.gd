extends CanvasLayer

signal dead

func _process(_delta):
	$TimeRemaining.text = ("%1.4f" % %TaskTime.time_left + " Seconds left")
	$Health/AnimatedSprite2D.frame = %PlayerShip.get("ship_health")
	$DashCooldown.value = %PlayerShip/ShipTimers/DashCooldown.get_time_left()
