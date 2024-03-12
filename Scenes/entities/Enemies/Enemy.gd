extends CharacterBody2D

const SPEED = 100

@onready var navigation = $NavigationAgent2D
@onready var animator = $AnimatedSprite2D

var player_node = GameMaster.get_current_player()

func _ready():
	animator.play("default")

func _physics_process(_delta):
	var dir = to_local(navigation.get_next_path_position()).normalized()
	print("Direction x: %f Direction y: %f" % [dir.x, dir.y])
	velocity = dir * SPEED
	move_and_slide()
	print("Trying to move")
	
func makepath() -> void:
	navigation.target_position = player_node.global_position
	



func _on_timer_timeout():
	makepath()
	print("I made a path to the player")
