extends Node2D

var laser_scene: PackedScene = preload("res://laser.tscn")
var grenade_scene: PackedScene = preload("res://grenade.tscn")


func _on_player_laser(pos, direction, rotation):
	var laser = laser_scene.instantiate()
	$Projectiles.add_child(laser)
	laser.speed = 300
	laser.rotation = direction.angle()
	laser.direction = direction
	laser.global_position = pos


func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	$Projectiles.add_child(grenade)
	grenade.global_position = pos
	grenade.linear_velocity = direction * grenade.speed
