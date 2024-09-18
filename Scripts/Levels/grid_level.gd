extends Node2D

@export var starting_view := ViewMode.SIDE_VIEW
@export_range(0, 8, 0.5) var ground_level := 7.5
@export var player_is_safe := false

@onready var player: CharacterBody2D = $Player
@onready var side_view: Node2D = $SideView
@onready var top_view: Node2D = $TopView

var cell_size := 16.0
var player_cell_coordinate: Vector2
var player_depth: float
var player_altitude: float
var current_view: ViewMode
var player_index_original
var player_index_behind_platforms := -30.0
var player_in_depth_safe_zone := false
var player_in_altitude_safe_zone := false

enum ViewMode
{
	SIDE_VIEW,
	TOP_VIEW,
	DOWN_VIEW
}


func _ready() -> void:
	get_player_position_on_grid()
	player_altitude = ground_level
	player_depth = ground_level
	player_index_original = player.z_index
	set_new_view(starting_view)


func _process(delta: float) -> void:
	get_player_position_on_grid()
	
	if Input.is_action_just_pressed("a_btn"):
		set_new_view(ViewMode.TOP_VIEW)
	if Input.is_action_just_pressed("b_btn"):
		set_new_view(ViewMode.SIDE_VIEW)
		
	if (player_in_depth_safe_zone && player_in_altitude_safe_zone):
		player_is_safe = true
		print("PLAYER IS SAFE")

func set_new_view(view: ViewMode) -> void:
	match view:
		ViewMode.SIDE_VIEW:
			side_view.activate_view(true)
			top_view.activate_view(false)
			new_player_position(player_altitude)
		ViewMode.TOP_VIEW:
			side_view.activate_view(false)
			top_view.activate_view(true)
			new_player_position(player_depth)
	player.player_control_type = view
	current_view = view


#region Player Positions
func new_player_position(y_cell_position: float) -> void:
	player.global_position = Vector2(
		player_cell_coordinate.x * cell_size, 
		y_cell_position * cell_size
	)

func get_player_position_on_grid():
	player_cell_coordinate = Vector2(
		player.global_position.x / cell_size, 
		player.global_position.y / cell_size
	) 
	match current_view:
		ViewMode.SIDE_VIEW:
			player_altitude = player_cell_coordinate.y
		ViewMode.TOP_VIEW:
			player_depth = player_cell_coordinate.y
#endregion


#region Safe Zone Evaluations
func track_safe_zone_depth(state: bool) -> void:
	if current_view != ViewMode.TOP_VIEW: return
	player_in_depth_safe_zone = state
	player.z_index = player_index_behind_platforms if state else player_index_original
	#print("Depth Safe Zone: " + str(state))

func track_safe_zone_altitude(state: bool) -> void:
	if current_view != ViewMode.SIDE_VIEW: return
	player_in_altitude_safe_zone = state
	if !state: reset_safe_zone_states()
	#print("Altitude Safe Zone: " + str(state))

func reset_safe_zone_states():
	player.z_index = player_index_original
	player_in_depth_safe_zone = false
	player_depth = ground_level
#endregion
