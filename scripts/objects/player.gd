extends CharacterBody2D
class_name Ship

## Sets the speed for the ship.
@export var speed: int = 150
## Sets what the divisor will be when using slow_speed.
## speed / slow_speed_divisor = slow_speed
@export var slow_speed_divisor: int = 2

## Sets what the speed for the dash will be.
## The same value type of value as speed
@export var dash_speed: int = 300

## Sets the ship health
@export var ship_health: float = 3

var can_primary: bool = true
var can_grenade: bool = true
var got_hit: bool = false
var can_dash: bool = true
var dashing: bool = false
var dead: bool = false

signal primary_fire(laser_info: Projectile)
signal after_death


func _physics_process(_delta):
	if dead:
		return
	if got_hit:
		visible = not visible
		
	move_and_slide()


## These functions are meant to be called in a _process
## direction is a normalized vector
func move(direction: Vector2):
	$Body.rotation = direction.angle()
	$Body/Flame.play("thrust")
	$ShipEffects/Thrust.emitting = true
	velocity = (direction * speed)



## halves velocity
func slow_move():
	velocity /= 2


## direction is a normalized vector
func dash(direction: Vector2):
	can_dash = false
	dashing = true
	$Body.rotation = direction.angle()
	$Body/Flame.play("dash")
	$ShipEffects/Dash.rotation = direction.angle() - rotation
	$ShipEffects/Dash.emitting = true
	$ShipTimers/DashLength.start()
	velocity = (direction * dash_speed)
	return


func shoot():
	can_primary = false
	$ShipTimers/Primary.start()

	$GunPivot/Shoot.emitting = true
	var ship_direction = (
		(get_global_mouse_position() - global_position).normalized()
	)
	var laser = ProjectileTemplate.new()
	laser.parent = self
	laser.direction = ship_direction
	laser.global_position = $GunPivot/ShootPoint.global_position
	laser.speed = 1000
	var damage = Damage.new()
	damage.damage = 1
	damage.knockback_direction = laser.direction
	damage.knockback_strength = laser.speed / 2
	laser.damage = damage
	
	primary_fire.emit(laser)


func hit(damage: int):
	if dashing or got_hit:
		return
	got_hit = true
	$ShipTimers/HitLag.start()
	$ShipEffects/Hit.emitting = true
	ship_health -= damage
	if ship_health <= 0:
		death()


func death():
	dead = true
	velocity = Vector2.ZERO
	dashing = true
	$GunPivot.queue_free()
	$Body.queue_free()
	$CollisionShape2D.queue_free()
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
	$ShipTimers/DashCooldown.start()
	dashing = false
