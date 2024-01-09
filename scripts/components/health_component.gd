extends Node2D

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
	$CollisionShape2D.queue_free()
	$Sprites.queue_free()
	$ShipEffects/Explode.emitting = true
	
func _on_after_explode():
	after_death.emit()
	queue_free()
