extends CharacterBody2D

const SPEED = 100

@onready var navigation = $NavigationAgent2D
@onready var animator = $AnimatedSprite2D
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
		if (navigation.distance_to_target() < 300):
			if(!animator.is_playing()):
				_handle_shoot()
			velocity = Vector2.ZERO
			
		elif (!(navigation.distance_to_target() > 600)):
			animator.play("run")
			var dir = to_local(navigation.get_next_path_position()).normalized()
			velocity = dir * SPEED
			
		else:
			animator.play("default")
			velocity = Vector2.ZERO
			
		if (velocity.x > 0):
			animator.flip_h = false
		elif (velocity.x < 0):
			animator.flip_h = true
		
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
	pass
	
func take_damage(dmg : int):
	health -= dmg
	if health < 0:
		is_dead = true
		_death()

func _on_timer_timeout():
	makepath()
	
func _handle_shoot():
		animator.stop()
		animator.play("shoot")
		var p = load("res://Scenes/enemy_projectile.tscn")
		var proj = p.instantiate()
		proj.set_bullet_velocity(global_position.direction_to(player_node.global_position))
		proj.position = global_position
		proj.add_collision_exception_with(self)
		get_node("/root").add_child(proj)
			
