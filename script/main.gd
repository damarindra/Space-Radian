
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var base_score setget get_base_score
var save_file = "res://save"

const SHIP_SPEED = 180
var isFire = false

func _ready():
	# Initalization here
	set_process_unhandled_input(true)
	var f = File.new()
	if f.file_exists(save_file):
		print("file founded")
		f.open(save_file, File.READ)
		if f.is_open():
			base_score = f.get_8()
			f.close()
		else :
			print("unable to read file")
	else:
		print("file not found")
	pass

func get_base_score():
	return base_score

func _unhandled_input(e):
	#android acc
	var t = e.type
	var touch = (t == InputEvent.SCREEN_TOUCH)
	if touch:
		if e.is_pressed():
			if isFire == false:
				#do something
				get_node("ship").fire()
				isFire = true
		else:
			isFire = false