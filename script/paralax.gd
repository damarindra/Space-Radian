
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

const BACK_SPEED = 20
const FRONT_SPEED = 45

func _ready():
	# Initalization here
	set_process(true)
	pass

func _process(delta):
	var back_pos = get_node("back").get_pos()
	var front_pos = get_node("front").get_pos()
	
	if front_pos.y >= 1200:
		front_pos = Vector2(240,400)
		get_node("front").set_pos(front_pos)
	if back_pos.y >= 1200:
		back_pos = Vector2(240, 400)
		get_node("back").set_pos(back_pos)
	
	back_pos.y+=BACK_SPEED*delta
	front_pos.y+=FRONT_SPEED*delta
	get_node("back").set_pos(back_pos)
	get_node("front").set_pos(front_pos)
	