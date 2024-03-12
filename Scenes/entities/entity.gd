extends CharacterBody2D

class_name Entity


@onready var animated_sprite = $AnimatedSprite2D

const FRICTION: float = .15
const acceleration: int = 300

var mov_direction: Vector2 = Vector2.ZERO


func _physics_process(_delta):
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	
func move():
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration
