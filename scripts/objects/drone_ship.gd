extends Projectile

@export var target: Ship

func _ready():
	 target = %Player

func _physics_process(delta):


