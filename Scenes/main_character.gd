extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(_delta):
	
	if (velocity.x > 1 || velocity.x < -1 || velocity.y > 1 || velocity.y < -1):
		sprite_2d.animation = "run"
	else:
		sprite_2d.animation = "default"
		
	# Handle shoot.
	if Input.is_action_just_pressed("shoot"):
		sprite_2d.animation = "shoot"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 15)
	
	if Input.is_action_just_pressed("left"):
		sprite_2d.flip_h = true
		
	if Input.is_action_just_pressed("right"):
		sprite_2d.flip_h = false
	var y_direction = Input.get_axis("up", "down")
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 15) 

	move_and_slide()
	
	
	
