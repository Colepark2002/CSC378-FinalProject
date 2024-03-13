extends CharacterBody2D


const SPEED = 300
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
var health
var damage
var crit

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	health = 100
	damage = 30
	crit = .01
	add_to_group("player")
	
func _physics_process(_delta):
	# Handle shoot.
	if Input.is_action_just_pressed("shoot"):
		_handle_shoot()
		
	# Handle Running and Idle Animation
	if ((velocity.x > 1 || velocity.x < -1 || velocity.y > 1 || velocity.y < -1) && !animation_player.is_playing()):
		animation_player.play("run")
	elif (!animation_player.is_playing()):
		animation_player.play("default")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 15)
		
	var y_direction = Input.get_axis("up", "down")
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 25) 
	
	if Input.is_action_just_pressed("left"):
		sprite_2d.flip_h = true	
	if Input.is_action_just_pressed("right"):
		sprite_2d.flip_h = false
		
	move_and_slide()
	
func _get_collisions():
	var c = get_last_slide_collision()
	if (c && c.get_collider()):
		return c.get_collider()
	else:
		return null

func take_damage(dmg : int):
	print("Took Damage: %d" % [dmg])
	health -= dmg
	if health < 0:
		_dead()
		
func _dead():
	pass
	
func _handle_shoot():
	if (!animation_player.current_animation == "shoot" || animation_player.is_playing()):
			animation_player.stop()
			animation_player.play("shoot")
			var p = load("res://Scenes/projectile.tscn")
			var proj = p.instantiate()
			proj.position = global_position
			proj.add_collision_exception_with(self)
			get_node("/root").add_child(proj)

