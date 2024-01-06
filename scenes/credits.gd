extends Node
# feb is gonna cook here he doesnt know what to cook yet
var my_sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $burger
	my_sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("burger"):
		my_sprite.visible = not my_sprite.visible


func _on_leave_button_up():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
