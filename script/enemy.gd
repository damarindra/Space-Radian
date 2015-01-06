
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var speed = 50
var dir = 70
var move_right = true

var bullet = preload("res://scene/bullete.xml")
var ship = preload("res://scene/ship.xml")

var fire_speed = 0.2
var time_to_fire = 1
var bulletArray = []
var id = 0
var isFire = false
var count_fire = 5

func _ready():
	# Initalization here
	set_process(true)
	pass

func _process(delta):
	var enemy_pos = get_pos()
	enemy_pos.y+=speed*delta
	
	if move_right:
		if enemy_pos.x > 480 - get_texture().get_size().x/2:
			move_right=false
		enemy_pos.x+=dir*delta
	elif move_right == false:
		if enemy_pos.x < 0 + get_texture().get_size().x/2:
			move_right=true
		enemy_pos.x-=dir*delta
	
	if time_to_fire<=0:
		#do something
		fire_speed-=delta
		if count_fire == 0:
			time_to_fire = 1
			count_fire = 5
		if fire_speed<=0:
			fire()
			fire_speed = 0.2
			count_fire -= 1
	else:
		time_to_fire-=delta
	set_pos(enemy_pos)
	
	var is_still_playing = get_parent().get_node("ship").get_game_status()
	
	var idB = 0
	for bullet in bulletArray:
		var bullet_pos = get_parent().get_node(bullet).get_pos()
		if bullet_pos.y > 800:
			get_parent().get_node(bullet).queue_free()
			bulletArray.remove(idB)
		idB+=1
	
	var restart = get_parent().get_node("ship").get_restart()
	if is_still_playing == false:
		for bullet in bulletArray:
			get_parent().get_node(bullet).queue_free()
		bulletArray.clear()

func fire():
	var bullet_instance = bullet.instance()
	var enemy_pos = get_pos()
	var bullet_pos = get_node("bullet_pos").get_pos()
	bullet_instance.set_pos(bullet_pos + enemy_pos)
	bullet_instance.set_name("bullet_enemy_"+str(id))
	get_parent().add_child(bullet_instance)
	bulletArray.push_back(bullet_instance.get_name())
	id+=1