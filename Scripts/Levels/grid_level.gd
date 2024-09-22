extends Node2D

@export var starting_view := ViewMode.SIDE_VIEW
@export var flash_view := ViewMode.TOP_VIEW
@export var next_level_scene: PackedScene = null
@export_category("Views")
@export var side_view: Node2D
@export var top_view: Node2D
@export var down_view: Node2D
@export_category("Position Parameters")
@export_range(0, 9, 0.5) var starting_altitude := 7.5
@export_range(0, 9, 0.5) var starting_depth := 7.5
@export_range(0, 9, 0.5) var ground_level := 7.5
#need to be turn to false on the levels with switch
@export var gameboy_off := true

@onready var player: CharacterBody2D = $Player

var cell_size := 16.0
var current_view: ViewMode
var listen_to_player_inputs := true
var wait_time_after_flash := 1.0

var player_cell_coordinate: Vector2
var player_depth: float
var player_altitude: float
var player_index_original
var player_index_behind_platforms := -30.0
var player_in_depth_safe_zone := false
var player_in_altitude_safe_zone := true
var player_is_safe := false
var gameboy_entity

enum ViewMode
{
	SIDE_VIEW,
	TOP_VIEW,
	DOWN_VIEW
}

func _enter_tree():
	gameboy_entity = get_tree().get_first_node_in_group("gameboy_entity")
	if gameboy_entity != null:
		gameboy_entity.game_boy_off.connect(turn_gameboy_off)
		print("game boy entity")
		
func turn_gameboy_off():
	print( "turn game boy off")
	gameboy_off = true

func _ready() -> void:
	get_player_position_on_grid()
	player_altitude = starting_altitude
	player_depth = starting_depth
	player_index_original = player.z_index
	set_new_view(starting_view)


func _process(delta: float) -> void:
	get_player_position_on_grid()
	
	if listen_to_player_inputs:
		if Input.is_action_just_pressed("a_btn"):
			set_new_view(ViewMode.TOP_VIEW)
		if Input.is_action_just_pressed("b_btn"):
			set_new_view(ViewMode.SIDE_VIEW)
		
	if (player_in_depth_safe_zone && player_in_altitude_safe_zone):
		player_is_safe = true
		print("PLAYER IS SAFE")
	else:
		player_is_safe = false


#region Change View
func set_new_view(view: ViewMode) -> void:
	match view:
		ViewMode.SIDE_VIEW:
			if side_view != null:
				side_view.activate_view(true)
				top_view.activate_view(false)
			new_player_position(player_altitude)
		ViewMode.TOP_VIEW:
			if top_view != null:
				side_view.activate_view(false)
				top_view.activate_view(true)
				new_player_position(player_depth)
	player.player_control_type = view
	current_view = view
#endregion


#region Player Positions
func new_player_position(y_cell_position: float) -> void:
	player.global_position = Vector2(
		player_cell_coordinate.x * cell_size, 
		y_cell_position * cell_size
	)

func get_player_position_on_grid() -> void:
	player_cell_coordinate = Vector2(
		player.global_position.x / cell_size, 
		player.global_position.y / cell_size
	) 
	match current_view:
		ViewMode.SIDE_VIEW:
			player_altitude = player_cell_coordinate.y
			if (player_altitude > ground_level - 0.5):
				player_on_ground_level()
		ViewMode.TOP_VIEW:
			player_depth = player_cell_coordinate.y

func player_on_ground_level() -> void:
	if player_in_depth_safe_zone: return
	player_depth = ground_level
#endregion


#region Safe Zone Evaluations
func track_safe_zone_depth(state: bool) -> void:
	if current_view != ViewMode.TOP_VIEW: return
	player_in_depth_safe_zone = state
	player.z_index = player_index_behind_platforms
	print("player depth safe " + str(state))

func track_safe_zone_altitude(state: bool) -> void:
	if current_view != ViewMode.SIDE_VIEW: return
	player_in_altitude_safe_zone = state
	print("player altitude safe " + str(state))
	if !state: reset_safe_zone_states()

func reset_safe_zone_states():
	player.z_index = player_index_original
	player_in_depth_safe_zone = false
#endregion


#region End Level Sequences
func _on_gameboy_entity_final_flash() -> void:
	set_new_view(flash_view)
	if player_is_safe and gameboy_off: level_completed()
	else: level_failed()

func level_completed() -> void:
	listen_to_player_inputs = false
	player.can_move = false
	print("Well Done!")
	await get_tree().create_timer(wait_time_after_flash).timeout
	if next_level_scene != null:
		get_tree().change_scene_to_packed(next_level_scene)
	else:
		get_tree().quit()

func level_failed() -> void:
	listen_to_player_inputs = false
	player.can_move = false
	print("Game Over")
	await get_tree().create_timer(wait_time_after_flash).timeout
	get_tree().reload_current_scene()
#endregion
