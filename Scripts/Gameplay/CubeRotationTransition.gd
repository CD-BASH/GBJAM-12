extends Marker3D

const FOLLOW_SPEED = 4.0
var target_rotation: Quaternion
var current_rotation: Quaternion
@export var rotation_speed: float = 14  # Control the speed of the slerp
var is_rotating: bool = false

func _ready():
	# Initialize the current rotation
	current_rotation = global_transform.basis.get_rotation_quaternion()
	target_rotation = current_rotation  # Initially, the target rotation is the same

func _process(delta):
	##if is_rotating:
		# Smoothly interpolate the rotation using slerp
		current_rotation = current_rotation.slerp(target_rotation, delta * rotation_speed)
		global_transform.basis = Basis(current_rotation)

		# Stop rotating when close enough to the target rotation
		if current_rotation.is_equal_approx(target_rotation):
			is_rotating = false

func RotateUp ()-> void : 
	var rotation_90_degrees = Quaternion(Vector3(1, 0, 0), deg_to_rad(90))
	target_rotation = target_rotation * rotation_90_degrees
	is_rotating = true
	
func RotateDown ()-> void : 
	var rotation_90_degrees = Quaternion(Vector3(1, 0, 0), deg_to_rad(-90))
	target_rotation = target_rotation * rotation_90_degrees
	is_rotating = true
