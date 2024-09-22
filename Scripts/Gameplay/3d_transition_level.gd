extends Node3D

@onready var front: MeshInstance3D = $Marker3D/Front
@onready var top: MeshInstance3D = $Marker3D/Top
@onready var mats : Material

@export_subgroup("front")
@export var subviewport_texture_front : ViewportTexture
@export_subgroup("Top")
@export var subviewport_texture_top : ViewportTexture

@export var freeze_viewport : SubViewport
@export var gameplay_viewport : SubViewport

# Called when the node enters the scene tree for the first time.
func _ready():
	front.mesh.material.set_shader_parameter("render_target",subviewport_texture_front)
	top.mesh.material.set_shader_parameter("render_target",subviewport_texture_top)
	## try that latter
	##SetMaterial(front.mesh.material, subviewport_front)
	##SetMaterial(top.mesh.material, subviewport_top)

func _process(delta):
	"""
	if Input.is_action_just_pressed("a_btn"):
		subviewport_front.render_target_update_mode = SubViewport.UPDATE_ONCE
		subviewport_front.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
		subviewport_top.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		subviewport_top.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
	
	if Input.is_action_just_pressed("b_btn"):
		subviewport_top.render_target_update_mode = SubViewport.UPDATE_ONCE
		subviewport_top.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
		subviewport_front.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		subviewport_front.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
	"""
	pass

func SetViewPortes() -> void : 
	
	pass
	

func SetMaterial(textureViewport: ViewportTexture) -> void:
	mats = ShaderMaterial.new()
	mats.shader = preload("res://Shaders/Video.gdshader")
	mats.set_shader_parameter("render_target",textureViewport)
	
