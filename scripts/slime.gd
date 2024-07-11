extends Node2D

const SPEED = 60

@onready var sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

var direction : int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_left.is_colliding():
		direction = 1
		sprite.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = true
	
	position.x += direction * SPEED * delta
