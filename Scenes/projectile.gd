extends CharacterBody2D

@onready var sprite = $Sprite2D

var player = GameMaster.get_current_player()
var speed = 1000


func _ready():
	velocity = player.global_position.direction_to(get_global_mouse_position()) * speed

func _physics_process(_delta):
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	if collision && collision.get_collider():
		var collider = collision.get_collider()
		if (collider.get_groups().size() && collider.get_groups().has("enemy")):
			collider.take_damage(player.damage)
		_explode()

func _explode():
	queue_free()
