extends CharacterBody2D

const SPEED = 100

@onready var navigation = $NavigationAgent2D
@onready var animator = $AnimatedSprite2D
@onready var gun_sound = $AudioStreamPlayer2D
@onready var hit_noise = $AudioStreamPlayer2D2
var damage
var is_dead = false
var health
var allow_spawn = false

var player_node = GameMaster.get_current_player()

func _ready():
	health = 500
	damage = 50
	add_to_group("enemy")
	add_to_group("boss")
	animator.play("default")

func _physics_process(_delta):
	if (!is_dead):
			
		if (!(navigation.distance_to_target() > 600)):
			animator.play("default")
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
	var root = get_node("/root")
	for n in root.get_children():
			root.remove_child(n)
			if !(n.get_groups().has("boss") || !(n.get_groups().has("player"))):
				n.queue_free()
	root.get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
	queue_free()
	#animator.play("death")
	
	
func allow_spawning():
	allow_spawn = true
	
func take_damage(dmg : int):
	health -= dmg
	hit_noise.play()
	if health < 0:
		is_dead = true
		_death()

func _on_timer_timeout():
	makepath()
			
func _spawnDrones():
	var d = load("res://Scenes/entities/Enemies/enemy.tscn")
	var drone1 = d.instantiate()
	drone1.add_collision_exception_with(self)
	drone1.position = global_position
	get_node("/root").add_child(drone1)

func _on_drone_timer_timeout():
	if allow_spawn:
		_spawnDrones()
	
