extends Node2D

@onready var tile_set_background: TileMapLayer = $TileSet_Background
@onready var tile_set_platforms: TileMapLayer = $TileSet_Platforms

func _ready() -> void:
	pass

func activate_view(state: bool):
	visible = state
	tile_set_background.enabled = state
	tile_set_platforms.enabled = state
