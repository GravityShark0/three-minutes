extends Node2D
class_name ProjectileTemplate

var speed: int
var damage := Damage.new()
var direction: Vector2
var rotation_speed: int
var parent: Ship
var explode_particle: GPUParticles2D
