extends MeshInstance3D
@export var speedy:float = 5
@export var speedx:float = 5
var time : float

func _process(delta):
	time += delta
	rotate_y(sin(time) * speedy )
	rotate_x(sin(time) * speedx )
