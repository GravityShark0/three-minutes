extends Projectile

## 0-3
var type: int = 0
##  0-5
var color: int = 0

func setup(laser_info: ProjectileTemplate):
	damage = laser_info.damage
	speed = laser_info.speed
	parent = laser_info.parent
	global_position = laser_info.global_position
	rotation = laser_info.direction.angle()
	direction = laser_info.direction
	scale *= laser_info.damage.damage
	$Sprite2D.region_rect.position.x = 16 * type
	$Sprite2D.region_rect.position.y = 16 * color

func _on_body_entered(body: Node2D):
	if body != parent:
		if body is Projectile:
			body.hit(damage)

func _on_area_entered(area: Area2D):
	if area is Projectile:
		area.hit(damage)

func _on_explode_finished():
	queue_free()
func _on_laser_timeout_timeout():
	queue_free()
