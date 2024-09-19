extends Node2D


@onready var tile_set_background: TileMapLayer = $TileSet_Background
@onready var tile_set_platforms: TileMapLayer = $TileSet_Platforms
@onready var area_switch: Node2D = $AreaSwitch


func activate_view(state: bool):
	visible = state
	tile_set_background.enabled = state
	tile_set_platforms.enabled = state
	area_switch.switch_areas_process_mode(state)
