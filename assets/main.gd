extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#add_child(GameMaster.spawn_enemy(1000, 100))
	#add_child(GameMaster.spawn_enemy(1000, 600))
	#add_child(GameMaster.spawn_enemy(20, 520))
	#add_child(GameMaster.spawn_enemy(500, 510 ))
	#add_child(GameMaster.spawn_ranged_enemy(600,40))
	add_child(GameMaster.spawn_current_player())
	var spawns = get_tree().get_nodes_in_group("spawn")
	var enemies = GameMaster.spawn_enemies(spawns)
	for i in enemies:
		add_child(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
