extends Node
var fsm: StateMachine


func enter():
	await get_tree().create_timer(0.2).timeout
	var forwardVector: Vector3 = fsm.camera.transform.basis.z.normalized()
	if Input.is_action_just_pressed("Sprint"):
		fsm.character.velocity = 60 * forwardVector
	fsm.character.move_and_slide()

func exit(state_name):
	fsm.change_to(state_name)

func _physics_process(delta: float) -> void:
	fsm.character.move_and_slide()
	if Input.is_action_just_released("Sprint"):
		exit("Idle")
