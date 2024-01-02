extends CharacterBody2D

const SPEED: int = 500
var can_laser: bool = true
var can_grenade: bool = true

signal laser(pos, direction, rotation)
signal grenade(pos, direction)


func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = (direction * SPEED)

	# position += (direction * delta * SPEED)
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("primary") and can_laser:
		var marker = $Lasers.get_children().pick_random()
		print("shoot laser")
		can_laser = false
		$Timers/LaserTimer.start()
		var player_rotation = rotation_degrees
		var player_direction = (
			(get_global_mouse_position() - global_position).normalized()
		)
		laser.emit(marker.global_position, player_direction, player_rotation)
	if Input.is_action_pressed("secondary") and can_grenade:
		can_grenade = false
		$Timers/GrenadeTimer.start()

		var marker = $Lasers.get_children().pick_random()
		var player_direction = (
			(get_global_mouse_position() - global_position).normalized()
		)
		print(player_direction)
		grenade.emit(marker.global_position, player_direction)

	move_and_slide()


func _on_laser_timer_timeout():
	print("laser timer stop")
	can_laser = true


func _on_grenade_timer_timeout():
	print("grenade timer stop")

	can_grenade = true
