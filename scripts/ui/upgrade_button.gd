@tool
extends Control

## The unique identifier
@export var upgrade_id: int
@export var upgrade_name: String
@export var upgrade_description: String
@export var value: int = 0
@export var max_value: int = 1
@export_category("Textures")
@export var normal: Texture2D
@export var pressed: Texture2D
@export var hover: Texture2D
@export var disabled: Texture2D
@export var focused: Texture2D

signal upgrade(id: int)


func _ready():
	$Name.text = upgrade_name
	$TextureButton.texture_normal = normal
	$TextureButton.texture_pressed = pressed
	$TextureButton.texture_hover = hover
	$TextureButton.texture_disabled = disabled
	$TextureButton.texture_focused = focused


func _process(_delta):
	if Engine.is_editor_hint():
		$Name.text = upgrade_name
		$TextureButton.texture_normal = normal


func _on_texture_button_pressed():
	upgrade.emit(upgrade_id)
