extends Node
var fsm: StateMachine


func enter():
	fsm.stateLabel.text = "DASH"
	var forwardVector: Vector3 = fsm.camera.transform.basis.z.normalized()
	if Input.is_action_just_pressed("Sprint"):
		fsm.character.velocity = 100 * forwardVector
	await get_tree().create_timer(0.2).timeout

func exit(state_name):
	fsm.change_to(state_name)

func _physics_process(delta: float) -> void:
	var forwardVector: Vector3 = fsm.camera.transform.basis.z.normalized()
	fsm.character.velocity = 100 * forwardVector
	fsm.character.move_and_slide()
	await get_tree().create_timer(0.2).timeout
	exit("Idle")
