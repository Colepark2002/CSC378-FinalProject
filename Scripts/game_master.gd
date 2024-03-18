extends Node

var player_node = null
var is_player_spawned = false
var count = 0
var rng = RandomNumberGenerator.new()

func get_current_player():
	if (player_node): return player_node
	else: return null
	
func spawn_current_player():
	if (is_player_spawned): return player_node
	
	var player = load("res://Scenes/main_character.tscn")
	player_node = player.instantiate()
	var pos_x = 0
	var pos_y = 0
	player_node.position = Vector2(pos_x, pos_y)
	
	var camera = Camera2D.new()
	camera.is_current()
	camera.zoom = Vector2(1.5, 1.5)
	
	player_node.add_child(camera)
	
	var hud = load("res://Scenes/HUD/HealthBar.tscn")
	var hud_node = hud.instantiate()
	player_node.add_child(hud_node)
	
	is_player_spawned = true
	return player_node
	
func spawn_enemy(pos : Vector2):
	var enemy = load("res://Scenes/entities/Enemies/enemy.tscn")
	var enemy_node =  enemy.instantiate()
	
	enemy_node.position = pos
	return enemy_node
	
func spawn_ranged_enemy(pos : Vector2):
	var enemy = load("res://Scenes/entities/Enemies/ranged_enemy.tscn")
	var enemy_node =  enemy.instantiate()
	
	enemy_node.position = pos
	return enemy_node
	
func spawn_boss(pos : Vector2):
	var enemy = load("res://Scenes/entities/Enemies/boss.tscn")
	var enemy_node =  enemy.instantiate()
	
	enemy_node.position = pos
	return enemy_node
	
func spawn_enemies(spawns):
	var enemies = []
	for i in range(spawns.size()):
		var enemy_type = rng.randi_range(0, 1)
		if (enemy_type == 1):
			enemies.append(spawn_enemy(spawns[i].global_position))
		else:
			enemies.append(spawn_ranged_enemy(spawns[i].global_position))
	return enemies

func _physics_process(_delta):
	count += 1
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
