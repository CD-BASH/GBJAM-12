extends Node2D

@export var starting_view := ViewMode.SIDE_VIEW
@export_range(0, 8, 0.5) var ground_level := 7.5

@onready var player: CharacterBody2D = $Player
@onready var side_view: Node2D = $SideView
@onready var top_view: Node2D = $TopView

var cell_size := 16.0
var player_cell_coordinate: Vector2
var player_depth: float
var player_ground_level: float
var current_view: ViewMode

enum ViewMode
{
	SIDE_VIEW,
	TOP_VIEW,
	DOWN_VIEW
}

func _ready() -> void:
	get_player_position_on_grid()
	player_depth = ground_level
	set_new_view(starting_view)
	

func _process(delta: float) -> void:
	get_player_position_on_grid()
	
	if Input.is_action_just_pressed("a_btn"):
		set_new_view(ViewMode.TOP_VIEW)
	if Input.is_action_just_pressed("b_btn"):
		set_new_view(ViewMode.SIDE_VIEW)


func set_new_view(view: ViewMode) -> void:
	match view:
		ViewMode.SIDE_VIEW:
			side_view.activate_view(true)
			top_view.activate_view(false)
			player.global_position = Vector2(
				player_cell_coordinate.x * cell_size, 
				7.5 * cell_size
			)
		ViewMode.TOP_VIEW:
			side_view.activate_view(false)
			top_view.activate_view(true)
			player.global_position = Vector2(
				player_cell_coordinate.x * cell_size, 
				player_depth * cell_size
			)
	player.player_control_type = view
	current_view = view


func new_player_position() -> void:
	var new_position 

func get_player_position_on_grid():
	player_cell_coordinate = Vector2(
		player.global_position.x / cell_size, 
		player.global_position.y / cell_size
	) 
	
	match current_view:
		ViewMode.TOP_VIEW:
			player_depth = player_cell_coordinate.y
