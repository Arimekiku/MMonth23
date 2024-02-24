extends CharacterBody2D
class_name PlayerController

@export var data : PlayerData

@onready var animator = $Smoother/AnimatedSprite2D

func _physics_process(delta):
	handle_movement(delta)
	handle_animation()

	move_and_slide()

func handle_movement(delta):
	var direction = Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = move_toward(velocity.x, data.speed * direction, data.acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, data.speed * direction, data.friction * delta)

func handle_animation(): 
	if velocity.x == 0:
		animator.play("idle")
	else:
		animator.flip_h = velocity.x < 0
		animator.play("run")
	
	if velocity.y > 0:
		animator.play("jump")
	elif velocity.y < 0:
		animator.play("fall")
