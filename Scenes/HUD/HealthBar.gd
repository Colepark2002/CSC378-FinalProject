extends Node2D

@onready var sprite = $AnimatedSprite2D

var current_state

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = 9
	sprite.set_frame_and_progress(current_state, 0)
	pass # Replace with function body.
	

func change_health_state(state: int):
	current_state = state
	sprite.set_frame_and_progress(state, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sprite.position.y = GameMaster.get_current_player().sprite_2d.position.y - 25
