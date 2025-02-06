extends Camera3D

const SENSITIVITY = 0.05
var q = Quaternion().normalized()
var new_rot = q

var base = Vector3(0,0,0)

func _process(_delta):
	$"../Control/Label".text = str(self.rotation) 

func _ready():
	q = rotation

	## Head Tilt ##
	if Input.is_action_pressed("Left"):
		var t = create_tween()
		t.tween_property(self, "rotation", Vector3(0,0,deg_to_rad(3)), 0.2)
	if Input.is_action_pressed("Right"):
		var t = create_tween()
		t.tween_property(self, "rotation", Vector3(0,0,deg_to_rad(-3)), 0.2)
	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right"):
		var t = create_tween()
		t.tween_property(self, "rotation", Vector3(base), 0.2)
	if Input.is_action_pressed("Right") and Input.is_action_pressed("Left"):
		var t = create_tween()
		t.tween_property(self, "rotation", Vector3(base), 0.2)
	## Head Tilt ##


##Quarternions for rotations
#func _unhandled_input(event):
	#if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
