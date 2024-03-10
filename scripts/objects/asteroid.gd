extends Projectile

func _ready():
	damage.damage = randi_range(1, 3)
	speed = randi_range(100, 150) / damage.damage
	print("changed speed ", speed)
	rotation_speed = randi_range(10, 180)
	damage.damage = randi_range(1, 3)
	$Sprite2D.region_rect.position = Vector2(randi_range(0, 3) * 16, randi_range(0, 2) * 16)
	$Sprite2D.modulate = Color(1, float(1) / damage.damage, float(1) / damage.damage, 1)
	scale = Vector2(damage.damage, damage.damage)

func _on_laser_timeout_timeout():
	queue_free()

func _on_body_entered(body: Node2D):
	if body is Ship:
		if not body.dashing:
			body.hit(damage.damage)
			var ship_health = Damage.new()		
			ship_health.damage = body.ship_health
			hit(ship_health)

func _on_area_entered(area: Area2D):
	if area is Projectile:
		area.hit(damage)

func hit_action(_taken_damage):
	$Sprite2D.modulate = Color(1, float(1) / damage.damage, float(1) / damage.damage, 1)
	scale = Vector2(damage.damage, damage.damage)

func _on_timer_timeout():
	queue_free()
func _on_explode_finished():
	queue_free()
