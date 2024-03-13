extends CharacterBody2D

var player = GameMaster.get_current_player()
var speed = 2.0


func _ready():
	velocity = player.velocity * speed

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
