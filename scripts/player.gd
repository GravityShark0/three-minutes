extends CharacterBody2D

const SLOW_SPEED: int = 100
const SPEED: int = 200
var can_laser: bool = true
var can_grenade: bool = true
var dashing: bool = false
var dash_multiplier: int = 500
var can_dash: bool = true
var player_health: int = 3
# var dash_length: int = 3

signal laser(pos, direction)
signal grenade(pos, direction)


func _process(_delta):
	if dashing:
		print(velocity)
		move_and_slide()
		return

	var direction = Input.get_vector("left", "right", "up", "down")

	if (
		Input.is_action_pressed("dash")
		and can_dash
		and velocity != Vector2(0, 0)
	):
		print("dash!")
		can_dash = false
		dashing = true
		$Effects/Dash.emitting = true
		$Timers/DashTime.start()
		$Timers/DashCooldown.start()
		velocity = (direction * dash_multiplier)
		return

	if direction:
		$Effects/Thrust.emitting = true
	else:
		$Effects/Thrust.emitting = false

	if Input.is_action_pressed("shift"):
		velocity = (direction * SLOW_SPEED)
	else:
		velocity = (direction * SPEED)

	move_and_slide()

	# position += (direction * delta * SPEED)
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("primary") and can_laser:
		var marker = $Lasers.get_children().pick_random()
		can_laser = false
		$Timers/LaserTimer.start()
		var player_rotation = rotation_degrees
		var player_direction = (
			(get_global_mouse_position() - global_position).normalized()
		)
		$Effects/Shoot.emitting = true
		laser.emit(marker.global_position, player_direction)
	if Input.is_action_pressed("secondary") and can_grenade:
		can_grenade = false
		$Timers/GrenadeTimer.start()

		var marker = $Lasers.get_children().pick_random()
		var player_direction = (
			(get_global_mouse_position() - global_position).normalized()
		)
		$Effects/Shoot.emitting = true
		grenade.emit(marker.global_position, player_direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true


func hit(damage):
	if not dashing:
		$Effects/Hit.emitting = true
		player_health -= damage
		if player_health <= 0:
			death()


func death():
	velocity = Vector2i.ZERO
	dashing = true
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	$Timers.queue_free()
	$Effects/Explode.emitting = true


func _on_explode_finished():
	queue_free()


func _on_dash_time_timeout():
	velocity = Vector2.ZERO
	dashing = false


func _on_dash_cooldown_timeout():
	can_dash = true
