extends CanvasLayer
@export_range(-10.0, 10.0) var sliderValueTransition := 0.0
@onready var post_Rect: ColorRect = $PostMaterial
@onready var subView_Port: SubViewport = $SubViewportContainer/SubViewport
var time : float
var rotationFormula : float

func _ready() -> void:
	subView_Port.UpdateMode.UPDATE_DISABLED
	subView_Port.ClearMode.CLEAR_MODE_NEVER

func _process(delta):
	"""
	if Input.is_action_just_pressed("up_dPad"):
		subView_Port.render_target_update_mode = SubViewport.UPDATE_ONCE
		subView_Port.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
		print_debug("up")
		
	if Input.is_action_just_pressed("left_dPad"):
		subView_Port.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		subView_Port.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
	
	time += delta
	rotationFormula = clamp(sin(time),-1.0,1.0)
	post_Rect.material.set_shader_parameter("rotation_angle",rotationFormula)
	"""
	##post_Rect.material.set_shader_parameter("rotation_angle",sliderValueTransition)
