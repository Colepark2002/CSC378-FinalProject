extends Node

@onready var music = $AudioStreamPlayer2D
@onready var droneSpawn = $Spawns/Drone
@onready var rangedSpawn = $Spawns/Ranged
@onready var bossSpawn = $Spawns/Boss
@onready var playerSpawn = $Spawns/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	var player = GameMaster.spawn_current_player()
	player.position = playerSpawn.global_position
	add_child(player)
	var drone = GameMaster.spawn_enemy(droneSpawn.global_position)
	var ranged = GameMaster.spawn_ranged_enemy(rangedSpawn.global_position)
	var boss = GameMaster.spawn_boss(bossSpawn.global_position)
	add_child(drone)
	add_child(ranged)
	add_child(boss)

# Called every frame. 'delta' is the elapsed time since the previous frame.da
func _process(_delta):
	var player_pos = GameMaster.get_current_player().global_position
	if  player_pos.x > 1025 && player_pos.x < 1080 && player_pos.y > 480 && player_pos.y < 540:
		for n in get_children():
			remove_child(n)
			if !(n.get_groups().has("player")):
				n.queue_free()
		get_tree().change_scene_to_file("res://assets/main.tscn")
