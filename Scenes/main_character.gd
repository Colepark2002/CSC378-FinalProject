extends CharacterBody2D


const SPEED = 300
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(_delta):
	# Handle shoot.
	if Input.is_action_just_pressed("shoot"):
		animation_player.stop()
		animation_player.play("shoot")
		
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
