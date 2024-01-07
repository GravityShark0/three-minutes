extends Node2D

## Assign what ship will be able to be controlled, by default it would get the parent node
@export var ship: Node2D = get_parent()

func _process(_delta):
	if ship.dashing:
		return

	ship.get_node("GunPivot").look_at(get_global_mouse_position())

	var direction = Input.get_vector("left", "right", "up", "down")

	if direction:
		if (Input.is_action_pressed("dash") and ship.can_dash):
			return ship.dash(direction)
		ship.move(direction)
	else:
		ship.velocity = Vector2.ZERO
		ship.get_node("Body/Flame").play("offthrust")

	if Input.is_action_pressed("shift"):
		ship.slow_move()


	
func _physics_process(_delta):
	if Input.is_action_pressed("primary") and ship.can_primary:
		ship.shoot()
