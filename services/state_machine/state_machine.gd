extends Node

@export var initial_state : BaseState

var current_state: BaseState
var states: Dictionary = { }

func _ready():
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.on_transition.connect(on_child_transitioned)
	
	if initial_state == null:
		printerr("Initial state if not assigned! Please assign.")
		return
	
	initial_state.enter()
	current_state = initial_state

func _process(delta):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func on_child_transitioned(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		printerr("Can't find state with name %s" % new_state_name.to_lower())
	
	current_state.exit()
	current_state = new_state
	new_state.enter()
