extends CharacterBody2D

const SLOW_PERCENT: int = 2
const SPEED: int = 200
var can_laser: bool = true
var can_grenade: bool = true
var dashing: bool = false
var dash_multiplier: int = 500
var can_dash: bool = true
var player_health: int = 3
var got_hit: bool = false

signal laser(pos, direction)
signal grenade(pos, direction)
signal after_death


func _process(_delta):
	if dashing:
		move_and_slide()
		return

	var direction = Input.get_vector("left", "right", "up", "down")

	if (
		Input.is_action_pressed("dash")
		and can_dash
		and velocity != Vector2(0, 0)
	):
		can_dash = false
		dashing = true
		$ShipEffects/Dash.rotation = direction.angle() - rotation
		$ShipEffects/Dash.emitting = true
		$Timers/DashTime.start()
		$Timers/DashCooldown.start()
		velocity = (direction * dash_multiplier)
		return

	if direction:
		$ShipEffects/Thrust.emitting = true

	velocity = (direction * SPEED)
	if Input.is_action_pressed("shift"):
		velocity /= 2

	move_and_slide()

	# position += (direction * delta * SPEED)
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("primary") and can_laser:
		can_laser = false
		$Timers/PrimaryTimer.start()

		var player_direction = (
			(get_global_mouse_position() - global_position).normalized()
		)
		$ShipEffects/Shoot.emitting = true
		laser.emit($ShootPoint.global_position, player_direction)


func _on_laser_timer_timeout():
	can_laser = true


func hit(damage):
	if dashing or got_hit:
		return

	got_hit = true
	$Timers/HitCooldown.start()
	$ShipEffects/Hit.emitting = true
	player_health -= damage
	if player_health <= 0:
		death()


func death():
	velocity = Vector2i.ZERO
	dashing = true
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	$Timers.queue_free()
	$ShipEffects/Explode.emitting = true
	after_death.emit()


func _on_dash_time_timeout():
	velocity = Vector2.ZERO
	dashing = false


func _on_hit_cooldown_timeout():
	got_hit = false


func _on_dash_cooldown_timeout():
	can_dash = true


func _on_ship_effects_after_explode():
	queue_free()
