extends Node3D

@onready var pivot_3d_cube : Marker3D = $Marker3D
@onready var front_plane: MeshInstance3D = $Marker3D/Front
@onready var top_plane: MeshInstance3D = $Marker3D/Top
@onready var mats : Material
@onready var timer3dTo2d : Timer = $container/Timer

var child_game : Node2D
var is_up = false
var transition_animation_done = true

@export var freeze_viewport : SubViewport
@export var gameplay_viewport : SubViewport
@export var main_game : Marker2D

func _ready():
	child_game = main_game.get_child(0)
	is_up = bool(child_game.starting_view)
	print_debug(bool(child_game.starting_view))
	SetMainGameHiarachyStart()

func _process(delta):
	if Input.is_action_just_pressed("a_btn") and is_up == false and transition_animation_done == true:
		ChangeTextureViewportUP()

	if Input.is_action_just_pressed("b_btn") and is_up == true and transition_animation_done == true:
		ChangeTextureViewportDown()

func ChangeTextureViewportUP() -> void : 
		TimerStart()
		main_game.reparent(freeze_viewport)
		front_plane.mesh.material.set_shader_parameter("render_target",freeze_viewport.get_texture())
		freeze_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
		freeze_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
		await get_tree().process_frame
		## Game under Gamplay Real time
		child_game.set_new_view(child_game.ViewMode.TOP_VIEW) ## change direction
		main_game.reparent(gameplay_viewport)
		## shader stuff
		top_plane.mesh.material.set_shader_parameter("render_target",gameplay_viewport.get_texture())
		gameplay_viewport.render_target_update_mode = SubViewport.UPDATE_WHEN_VISIBLE
		gameplay_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
		## rotate cube setup variable
		pivot_3d_cube.RotateUp()
		is_up = true

func ChangeTextureViewportDown() -> void : 
		TimerStart()
		main_game.reparent(freeze_viewport)
		top_plane.mesh.material.set_shader_parameter("render_target",freeze_viewport.get_texture())
		freeze_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
		freeze_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
		await get_tree().process_frame
		## Game under Gamplay Real time
		child_game.set_new_view(child_game.ViewMode.SIDE_VIEW) ## change direction
		main_game.reparent(gameplay_viewport)
		## shader stuff
		front_plane.mesh.material.set_shader_parameter("render_target",gameplay_viewport.get_texture())
		gameplay_viewport.render_target_update_mode = SubViewport.UPDATE_WHEN_VISIBLE
		gameplay_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
		## rotate cube setup variable
		pivot_3d_cube.RotateDown()
		is_up = false

func TimerStart() -> void : 
	transition_animation_done = false
	timer3dTo2d.start()

func SetMainGameHiarachyStart() -> void : 
	main_game.reparent(self)
	move_child(main_game,0) ## make sure that the main game stays on top

func _on_timer_timeout():
	transition_animation_done = true
	SetMainGameHiarachyStart()
