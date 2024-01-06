extends Node

var music_bus = AudioServer.get_bus_index("Master")

#febs cooking place cause he doesnt knwo where ot cook anymore

signal back_from_settings
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_leave_button_up():
	back_from_settings.emit()


func _on_master_value_changed(value):
	volume(0, value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_sound_fx_value_changed(value):
	volume(2, value)


func _on_button_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))


func _on_sprite_button_button_up():
	$Sprites.visible = not $Sprites.visible
