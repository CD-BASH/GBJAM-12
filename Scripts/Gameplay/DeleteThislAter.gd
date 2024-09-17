extends ColorRect
var time : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	material.set_shader_parameter("rotation_angle",abs(sin(time) *3))
