extends CanvasLayer


func _process(_delta):
	$TimeRemaining.text = ("%10.4f" % %TaskTime.time_left + " Seconds left")
	$Health.text = "Health: " + str(%Player.get("player_health"))