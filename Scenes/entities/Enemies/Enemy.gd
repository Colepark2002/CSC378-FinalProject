extends CharacterBody2D

const SPEED = 350

@onready var navigation = $NavigationAgent2D
@onready var animator = $AnimatedSprite2D
@onready var explosion = $AudioStreamPlayer2D
var damage
var is_dead = false
var health

var player_node = GameMaster.get_current_player()

func _ready():
	health = 50
	damage = 20
	add_to_group("enemy")
	animator.play("default")

func _physics_process(_delta):
	if (!is_dead):
		if (!(navigation.distance_to_target() > 400)):
			var dir = to_local(navigation.get_next_path_position()).normalized()
			velocity = dir * SPEED
		
		var c = _get_collisions()
		if (c && (c.get_groups().size() && c.get_groups().has("player"))):
			is_dead = true
			_death()
			c.take_damage(damage)
			
			
		move_and_slide()
	else:
		if (!animator.is_playing()):
			queue_free()
	
	
func makepath() -> void:
	navigation.target_position = player_node.global_position

func _get_collisions():
	var c = get_last_slide_collision()
	if (c && c.get_collider()):
		return c.get_collider()
	else:
		return null
	

func _death():
	animator.play("death")
	explosion.play()
	pass
	
func take_damage(dmg : int):
	health -= dmg
	velocity.x *= -5
	velocity.y *= -5
	move_and_slide()
	if health < 0:
		is_dead = true
		_death()

func _on_timer_timeout():
	makepath()
