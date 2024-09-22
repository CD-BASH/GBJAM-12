extends Node3D

@onready var front: MeshInstance3D = $Marker3D/Front
@onready var top: MeshInstance3D = $Marker3D/Top
@export var subviewport_front : ViewportTexture
@export var subviewport_top : ViewportTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	front.mesh.material.set_shader_parameter("render_target",subviewport_front)
	top.mesh.material.set_shader_parameter("render_target",subviewport_top)
	
	##SetMaterial(front.mesh.material, subviewport_front)
	##SetMaterial(top.mesh.material, subviewport_top)

func _process(delta):
	pass

func SetMaterial(mat :Material, textureViewport: ViewportTexture) -> void:
	mat = ShaderMaterial.new()
	mat.shader = preload("res://Shaders/Video.gdshader")
	mat.set_shader_parameter("render_target",textureViewport)
