extends CharacterBody2D

@onready var sprite = $Sprite2D

var player = GameMaster.get_current_player()
var speed = 500
var damage = 20


func set_bullet_velocity(dir: Vector2):
	velocity = dir * speed

func _physics_process(_delta):
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	if collision && collision.get_collider():
		var collider = collision.get_collider()
		if (collider.get_groups().size() && collider.get_groups().has("player")):
			collider.take_damage(damage)
		_explode()

func _explode():
	queue_free()
