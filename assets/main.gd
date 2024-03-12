extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(GameMaster.spawn_current_player())
	add_child(GameMaster.spawn_enemy())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
