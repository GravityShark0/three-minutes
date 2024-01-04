extends CharacterBody2D
class_name Player

## Sets the speed for the player.
@export var speed: int = 150
## Sets what the divisor will be when using slow_speed.
## speed / slow_speed_divisor = slow_speed
@export var slow_speed_divisor: int = 2

## Sets what the speed for the dash will be.
## The same value as speed
@export var dash_speed: int = 300

## Sets the player health
@export var player_health: int = 3

var can_primary: bool = true
var can_grenade: bool = true
var got_hit: bool = false
var can_dash: bool = true
var dashing: bool = false

signal primary_fire(node: Node, pos: Vector2, direction: float)
signal after_death

func _process(_delta):
	if got_hit:
		visible = not visible
	
	if dashing:
		return move_and_slide()

	var direction = Input.get_vector("left", "right", "up", "down")

	if direction:
		if (Input.is_action_pressed("dash") and can_dash):
			return dash(direction)
		$ShipEffects/Thrust.emitting = true

	velocity = (direction * speed)
	if Input.is_action_pressed("shift"):
		velocity /= 2

	move_and_slide()
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("primary") and can_primary:
		can_primary = false
		$ShipTimers/Primary.start()

		$ShipEffects/Shoot.emitting = true
		var player_direction = (
			(get_global_mouse_position() - global_position).normalized()
		)
		primary_fire.emit(self, $ShootPoint.global_position, player_direction)


func dash(direction: Vector2):
	can_dash = false
	dashing = true
	$ShipEffects/Dash.rotation = direction.angle() - rotation
	$ShipEffects/Dash.emitting = true
	$ShipTimers/DashLength.start()
	velocity = (direction * dash_speed)
	return

func hit(damage: int):
	if dashing or got_hit:
		return

	got_hit = true
	$ShipTimers/HitLag.start()
	$ShipEffects/Hit.emitting = true
	player_health -= damage
	if player_health <= 0:
		death()

func death():
	velocity = Vector2i.ZERO
	dashing = true
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	$ShipEffects/Explode.emitting = true

func _on_ship_effects_after_explode():
	after_death.emit()
	queue_free()

func _on_ship_timers_primary_timeout():
	can_primary = true
func _on_ship_timers_special_timeout():
	pass  # Replace with function body.
func _on_ship_timers_hit_lag_timeout():
	got_hit = false
	visible = true
func _on_ship_timers_dash_cooldown_timeout():
	can_dash = true
func _on_ship_timers_dash_timeout():
	$ShipTimers/DashCool.start()
	dashing = false










