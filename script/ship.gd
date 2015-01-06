
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

const SHIP_SPEED = 180

var isFire = false

var ship_first_pos = Vector2(240, 700)

var bullet = preload("res://scene/bullet.xml")
var bulletArray = []
var idBullet = 0
var bullet_size

var enemy = preload("res://scene/enemy.xml")
var enemyArray = []
var idEnemy = 0
var enemy_time = 2
var enemy_size

var is_game_running setget set_game_status, get_game_status

var score = 0 setget get_score

var save_file = "res://save"

var restartCheck setget set_restart, get_restart

func _ready():
	# Initalization here
	is_game_running = true
	restartCheck = false
	enemy_size = enemy.instance().get_texture().get_size()
	bullet_size = bullet.instance().get_texture().get_size()
	set_process(true)
	pass

func set_restart(c):
	restartCheck = c
func get_restart():
	return restartCheck
func get_score():
	return score

func game(delta):
	var ship_pos = get_pos()
	var acc = Input.get_accelerometer()
	if ship_pos.x <= 0:
		#do nothing
		if acc.x < 0:
			ship_pos.x -= acc.x*SHIP_SPEED*delta
	elif ship_pos.x >= 480:
		if acc.x > 0:
			ship_pos.x -= acc.x*SHIP_SPEED*delta
	else:
		ship_pos.x -= acc.x*SHIP_SPEED*delta
	
	if Input.is_action_pressed("control_left"):
		ship_pos.x-=SHIP_SPEED*delta
	elif Input.is_action_pressed("control_right"):
		ship_pos.x+=SHIP_SPEED*delta
	if Input.is_action_pressed("control_fire"):
		if isFire == false:
			#do something
			fire()
			isFire = true
	else:
		isFire = false
	
	
	
	set_pos(ship_pos)
	
	#bullet behaviour
	var iB = 0
	for bullet in bulletArray:
		var bullet_pos = get_parent().get_node(bullet).get_pos()
		var bullet_rect = Rect2(bullet_pos - bullet_size/2, bullet_size)
		if bullet_pos.y < 0:
			get_parent().get_node(bullet).queue_free()
			bulletArray.remove(iB)
		
		#check if bullet touch enemy
		var iE = 0
		for enemy in enemyArray:
			var enemy_pos = get_parent().get_node(enemy).get_pos()
			var enemy_rect = Rect2(enemy_pos - enemy_size/2, enemy_size)
			
			if bullet_rect.intersects(enemy_rect):
				get_parent().get_node(bullet).queue_free()
				bulletArray.remove(iB)
				get_parent().get_node(enemy).queue_free()
				enemyArray.remove(iE)
				score+=1
				print("gotcha")
			iE+=1
		
		iB+=1
	
	var iE =0
	for enemy in enemyArray:
		var enemy_pos = get_parent().get_node(enemy).get_pos()
		if enemy_pos.y > 800 + enemy_size.y/2:
			get_parent().get_node(enemy).queue_free()
			enemyArray.remove(iE)
		iE+=1
	
	#enemy come out
	enemy_time-=delta
	if enemy_time <= 0:
		enemy_time = 2
		enemySpawn()
		print("SPAWN")
	get_parent().get_node("Score").get_node("point").set_text(str(score))


func set_game_status(status):
	is_game_running = status
func get_game_status():
	return is_game_running

func fire():
	#do something
	var bullet_instance = bullet.instance()
	var bullet_pos = get_node("bullet_pos").get_pos()
	var ship_pos = get_pos()
	bullet_instance.set_name("bullet_"+str(idBullet))
	bullet_instance.set_pos(bullet_pos + ship_pos)
	get_parent().add_child(bullet_instance)
	bulletArray.push_back(bullet_instance.get_name())

func enemySpawn():
	var enemy_instance = enemy.instance()
	var enemy_pos = Vector2(rand_range(0 + enemy_size.x/2, 480 - enemy_size.x/22), 0 - enemy_size.y/2)
	enemy_instance.set_pos(enemy_pos)
	enemy_instance.set_name("enemy_"+str(idEnemy))
	get_parent().add_child(enemy_instance)
	enemyArray.push_back(enemy_instance.get_name())

func restart():
	restartCheck = true
	for enemy in enemyArray:
		get_parent().get_node(enemy).queue_free()
	for bullet in bulletArray:
		get_parent().get_node(bullet).queue_free()
	enemyArray.clear()
	bulletArray.clear()
	set_pos(ship_first_pos)
	score = 0
	set_game_status(true)
	
func _process(delta):
	if is_game_running == true:
		game(delta)
		get_parent().get_node("Score").show()
	elif is_game_running == false:
		var f = File.new()
		var err = f.open(save_file, File.WRITE)
		f.store_8(score)
		f.close()
		get_parent().get_node("Score").hide()


func _on_core_input_event():
	pass # replace with function body
