extends Node

var player_node = null
var is_player_spawned = false
var count = 0

func get_current_player():
	if (player_node): return player_node
	else: return null
	
func spawn_current_player():
	if (is_player_spawned): return
	
	var player = load("res://Scenes/main_character.tscn")
	player_node = player.instantiate()
	var pos_x = 40
	var pos_y = 40
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
	
func spawn_enemy(x: int, y: int):
	var enemy = load("res://Scenes/entities/Enemies/enemy.tscn")
	var enemy_node =  enemy.instantiate()
	
	enemy_node.position = Vector2(x, y)
	return enemy_node

func _physics_process(_delta):
	count += 1
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
