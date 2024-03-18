extends Node

@onready var music = $AudioStreamPlayer2D
@onready var bossSpawn = $Spawns/Boss
@onready var playerSpawn = $Spawns/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	var player = GameMaster.spawn_current_player()
	player.position = playerSpawn.global_position
	add_child(player)
	var boss = GameMaster.spawn_boss(bossSpawn.global_position)
	boss.allow_spawning()
	add_child(boss)

func end_game():
	for n in get_children():
			remove_child(n)
			if !(n.get_groups().has("player")):
				n.queue_free()
	get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")
