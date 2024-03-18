extends Node

@onready var music = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	add_child(GameMaster.spawn_current_player())
	var spawns = get_tree().get_nodes_in_group("spawn")
	var enemies = GameMaster.spawn_enemies(spawns)
	for i in enemies:
		add_child(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
