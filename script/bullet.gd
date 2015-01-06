
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"


const BULLET_SPEED = 250

func _ready():
	# Initalization here
	set_process(true)
	pass

func _process(delta):
	var movement = get_pos()
	movement.y-=BULLET_SPEED*delta
	set_pos(movement)
