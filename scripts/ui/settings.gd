extends Node

var master = AudioServer.get_bus_index("Master")
var music = AudioServer.get_bus_index("Music")
var sfx = AudioServer.get_bus_index("SFX")

signal back_from_settings


func _on_leave_button_up():
	back_from_settings.emit()

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)
func mute(bus_index, value):
	AudioServer.set_bus_mute(bus_index, value)

func _on_master_value_changed(value):
	if value == -6:
		mute(master, true)
	else:
		mute(master, false)
		volume(master, value)

func _on_sound_fx_value_changed(value):
	if value == -6:
		mute(sfx, true)
	else:
		mute(sfx, false)
		volume(sfx, value)

func _on_music_value_changed(value):
	if value == -6:
		mute(music, true)
	else:
		mute(music, false)
		volume(music, value)


func _on_sprite_button_pressed():
	$Sprites.visible = not $Sprites.visible
