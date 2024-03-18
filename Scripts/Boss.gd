extends CharacterBody2D

const SPEED = 100

@onready var navigation = $NavigationAgent2D
@onready var animator = $AnimatedSprite2D
@onready var gun_sound = $AudioStreamPlayer2D
@onready var hit_noise = $AudioStreamPlayer2D2
var damage
var is_dead = false
var health

var player_node = GameMaster.get_current_player()

func _ready():
	health = 500
	damage = 50
	add_to_group("enemy")
	animator.play("default")

func _physics_process(_delta):
	if (!is_dead):
			
		if (!(navigation.distance_to_target() > 600)):
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
			c.take_damage(damage)
			var direction = global_position.direction_to(player_node.global_position) * -1
			velocity = direction * SPEED
			
			
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
	hit_noise.play()
	if health < 0:
		is_dead = true
		_death()

func _on_timer_timeout():
	makepath()
	
func _handle_shoot():
		animator.stop()
		animator.play("shoot")
		gun_sound.play()
		var p = load("res://Scenes/enemy_projectile.tscn")
		var proj = p.instantiate()
		proj.set_bullet_velocity(global_position.direction_to(player_node.global_position))
		proj.position = global_position
		proj.add_collision_exception_with(self)
		get_node("/root").add_child(proj)
			
func _spawnDrones():
	var d = load("res://Scenes/entities/Enemies/enemy.tscn")
	var drone1 = d.instantiate()
	drone1.add_collision_exception_with(self)
	drone1.position = global_position
	get_node("/root").add_child(drone1)

func _on_drone_timer_timeout():
	_spawnDrones()
	
