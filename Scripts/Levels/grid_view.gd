extends Node2D

@onready var tile_set_background: TileMapLayer = $TileSet_Background
@onready var tile_set_platforms: TileMapLayer = $TileSet_Platforms

func activate_view(state: bool):
	visible = state
	tile_set_background.enabled = state
	tile_set_platforms.enabled = state
	self.process_mode = Node.PROCESS_MODE_INHERIT if state else Node.PROCESS_MODE_DISABLED
