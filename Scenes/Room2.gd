extends Node

@onready var music = $AudioStreamPlayer2D
@onready var player_spawn = $Spawns/player


# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	var player = GameMaster.spawn_current_player()
	player.position = player_spawn.global_position
	add_child(player)
	var spawns = get_tree().get_nodes_in_group("spawn")
	var enemies = GameMaster.spawn_enemies(spawns)
	for i in enemies:
		add_child(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_pos = GameMaster.get_current_player().global_position
	if  player_pos.x < 97 && player_pos.x > 60 && player_pos.y < 40:
		for n in get_children():
			remove_child(n)
			if !(n.get_groups().has("player")):
				n.queue_free()
		get_tree().change_scene_to_file("res://Scenes/BossRoom.tscn")
