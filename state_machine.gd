extends Node

class_name StateMachine

var currentState: Object
var states = {}
var history = []
@onready var camera: Camera3D = $"../Head/Camera3D"
@onready var stateLabel = $"../../UI/State/Label"
@onready var character: CharacterBody3D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state in get_children():
		state.fsm = self
		states[state.name] = state
		if currentState:
			remove_child(state)
		else:
			currentState = state
	currentState.enter()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_to(state_name):
	history.append(currentState.name)
	set_state(state_name)

func back():
	if history.size() > 0:
		set_state(history.pop_back())

func set_state(state_name):
	remove_child(currentState)
	currentState = states[state_name]
	add_child(currentState)
	currentState.enter()
	
func _physics_process(delta: float) -> void:
	apply_gravity(delta)

func apply_gravity(delta: float):
	character.velocity.y -= 9.8 * delta
