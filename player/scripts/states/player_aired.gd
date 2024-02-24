extends BaseState
class_name PlayerAired

@export var player : PlayerController
@export var coyote_timer : Timer

@onready var jump_offset = player.data.jump_velocity / 2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	if player.velocity.y == 0:
		coyote_timer.start()

func update(_delta: float):
	if coyote_timer.time_left > 0:
		if Input.is_action_just_pressed("player_jump"):
			player.velocity.y = player.data.jump_velocity
	elif Input.is_action_just_released("player_jump") and player.velocity.y < jump_offset:
		player.velocity.y = jump_offset

func physics_update(delta):
	player.velocity.y += gravity * delta
	
	if player.is_on_floor():
		on_transition.emit(self, "PlayerGrounded")
