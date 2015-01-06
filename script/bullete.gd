
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

const SPEED = 300

func _ready():
	# Initalization here
	set_process(true)
	pass

func _process(delta):
	var movement = get_pos()
	rotate(180)
	movement.y+=SPEED*delta
	var ship_rect = Rect2(get_parent().get_node("ship").get_pos() - get_parent().get_node("ship").get_texture().get_size()/2, get_parent().get_node("ship").get_texture().get_size())
	
	#check if the ship has point with bullet
	if ship_rect.has_point(movement):
		get_parent().get_node("ship").set_game_status(false)
		print("YOU LOSE")
	
	set_pos(movement)
