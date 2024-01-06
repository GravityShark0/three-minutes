extends Node

# We are going to assume that you put this component as a child of a ship and a ship only
@onready var ship = get_node("../")

func _process(_delta):
	if ship.dashing:
		return

	var direction = Input.get_vector("left", "right", "up", "down")

	if direction:
		if (Input.is_action_pressed("dash") and ship.can_dash):
			return ship.dash(direction)
		ship.move(direction)
	else:
		ship.move(Vector2.ZERO)

	if Input.is_action_pressed("shift"):
		ship.slow_move()

	ship.look_at(ship.get_global_mouse_position())
	
func _physics_process(delta):
	if Input.is_action_pressed("primary") and ship.can_primary:
		ship.shoot()
