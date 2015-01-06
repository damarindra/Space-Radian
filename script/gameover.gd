
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	set_process(true)
	pass

func _process(delta):
	var still_playing = get_parent().get_node("ship").get_game_status()
	if still_playing:
		hide()
	elif still_playing == false:
		show()
		var score = get_parent().get_node("ship").get_score()
		get_node("score").set_text(str(score))

func _on_game_over_visibility_changed():
	pass # replace with function body

func _on_again_pressed():
	get_parent().get_node("ship").restart()
	print("touched")
