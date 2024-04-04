extends Node2D

const LEADERBOARD = preload("res://scenes/leaderboard.tscn")

@onready var player: CharacterBody2D = $player
@onready var timer: Timer = $Timer
@onready var spawn_dummy: Area2D = $spawn_dummy
@onready var label: Label = $Label
@onready var menu_button: Button = $main_menu/VBoxContainer/menu_button
@onready var menu_label: Label = $main_menu/VBoxContainer/menu_label
@onready var main_menu: Control = $main_menu
@onready var secondary_button: Button = $main_menu/VBoxContainer/secondary_button

var points : int
var game_state = 0
var toggle := 0
var spawn_rate:float
var diff_mult : float = 1
var speed_mult:float
var scaling:= 1

const FLOOR_ENEMY = preload("res://scenes/floor_enemy.tscn")
const FLYING_ENEMY = preload("res://scenes/flying_enemy.tscn")
const JUMPING_ENEMY = preload("res://scenes/jumping_enemy.tscn")
const DIVING_ENEMY = preload("res://scenes/diving_enemy.tscn")

var enemies :Dictionary = {
	0: FLOOR_ENEMY,
	1: FLYING_ENEMY,
	2: FLOOR_ENEMY, #and flying
	3: DIVING_ENEMY,
	4: JUMPING_ENEMY,
	5: JUMPING_ENEMY #and diving
}

func _ready() -> void:
	if Global.skip_main == true:
		game_state = 1
		Global.skip_main = false
	pass

func _process(delta: float) -> void:
	
	
	
	
	spawn_rate = (3 / (diff_mult*2))
	
	label.text = "Points: "+str(points)
	
	if not is_instance_valid(player):
		game_state = 2
	else:
		player.get_node("Sprite2D").speed_scale = diff_mult
	
	if game_state == 0:
		label.hide()
		player.hide()
		menu_button.text = "Start Game"
		menu_label.text = "Lil' Hopper"
		secondary_button.text = "Leaderboard"
	elif game_state == 1:
		get_tree().paused = false
		main_menu.hide()
		label.show()
		player.show()
		
		if Input.is_action_just_pressed("ui_cancel"):
			game_state = 4
	elif game_state == 2:
		label.hide()
		main_menu.show()
		if points > Global.high_score:
			Global.high_score = points
		menu_button.text = "Restart"
		menu_label.text = "Game Over\nScore: "+str(points)+"\nHigh Score: "+str(Global.high_score)
		secondary_button.text = "Quick Restart"
		game_state += 1
	elif game_state == 4:
		main_menu.show()
		menu_button.text = "Resume"
		menu_label.text = "Game\nPaused"
		secondary_button.text = "Quick Restart"
		game_state += 1
	else: pass
	
	if game_state == 3 or game_state == 5:
		get_tree().paused = true


func _on_timer_timeout() -> void:
	timer.wait_time = spawn_rate * randf_range(0.9,1.1)
	var enemy1 : Node = null
	var enemy2 : Node = null

	var rando = randi_range(0,scaling)
	
	if rando == 2:
		enemy1 = enemies[2].instantiate()
		enemy2 = enemies[1].instantiate()
	if rando == 5:
		enemy1 = enemies[5].instantiate()
		enemy2 = enemies[3].instantiate()
	else:
		enemy1 = enemies[rando].instantiate()
	
	print(str(rando))
	#else:
	#	enemy = enemies[toggle].instantiate()
	#	toggle += 1
	#	if toggle == 2:
	#		toggle = 0
		#print(str(toggle))

	enemy1.speed *= diff_mult
	if not enemy2 == null:
		enemy2.speed *= diff_mult/1.2
	
	
	self.add_child(enemy1)
	if not enemy2 == null:
		self.add_child(enemy2)
	enemy1.position = spawn_dummy.position
	if not enemy2 == null:
		enemy2.position = spawn_dummy.position
	#print(str(spawn_rate))
	timer.start()
	pass # Replace with function body.


func _on_pass_check_body_entered(body: Node2D) -> void:
	points += 1
	if points == 5 or points == 15 or points == 25 or points == 35:
		scaling += 1
	if points < 42:
		diff_mult += 0.01
	else:
		diff_mult += 0.001
	body.queue_free()
	pass # Replace with function body.


func _on_menu_button_pressed() -> void:
	if game_state == 0: #start game
		timer.start(0.3)
		game_state = 1
	if game_state == 5: #resume game
		get_tree().paused = false
		game_state = 1
	if game_state == 3: #restart game
		get_tree().paused = false
		get_tree().reload_current_scene()
	else:
		pass # Replace with function body.


func _on_secondary_button_pressed() -> void:
		if game_state == 0: #leaderboards
			var leaderboard = LEADERBOARD.instantiate()
			add_child(leaderboard)
		elif game_state == 5: #quick restart
			Global.quick_restart()
			get_tree().reload_current_scene()
		elif game_state == 3: #quick restart
			Global.quick_restart()
			get_tree().reload_current_scene()
		else:
			pass # Replace with function body.
