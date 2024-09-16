extends Node2D

@export var starting_view := ViewMode.SIDE_VIEW
@export_range(0, 8, 1) var starting_depth_position := 7.0

@onready var player: CharacterBody2D = $Player
@onready var side_view: Node2D = $SideView
@onready var top_view: Node2D = $TopView

var cell_size := 16.0
var player_cell_coordinate: Vector2
var player_depth: float

enum ViewMode
{
	SIDE_VIEW,
	TOP_VIEW,
	DOWN_VIEW
}

func _ready() -> void:
	set_new_view(starting_view)
	player_depth = starting_depth_position
	


func _process(delta: float) -> void:
	player_cell_coordinate = Vector2(
		player.global_position.x / cell_size, 
		player.global_position.y / cell_size
	) 
	
	if Input.is_action_just_pressed("a_btn"):
		set_new_view(ViewMode.TOP_VIEW)
	if Input.is_action_just_pressed("b_btn"):
		set_new_view(ViewMode.SIDE_VIEW)


func set_new_view(view: ViewMode):
	player.player_control_type = view
	
	match view:
		ViewMode.SIDE_VIEW:
			side_view.activate_view(true)
			top_view.activate_view(false)
			player.global_position = Vector2(player.global_position.x, 7.5 * cell_size)
			
		ViewMode.TOP_VIEW:
			side_view.activate_view(false)
			top_view.activate_view(true)
			player.global_position = Vector2(player.global_position.x, player_depth * cell_size)


func set_player_position_on_grid():
	pass
