extends BaseState
class_name PlayerGrounded

@export var player : PlayerController

func update(_delta: float):
	if Input.is_action_just_pressed("player_jump"):
		player.velocity.y = player.data.jump_velocity
		on_transition.emit(self, "PlayerAired")
	
	if not player.is_on_floor():
		on_transition.emit(self, "PlayerAired")
