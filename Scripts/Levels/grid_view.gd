extends Node2D

@export var background: ParallaxBackground
@export var tilemaps: Array[TileMapLayer]

func activate_view(state: bool):
	visible = state
	for tilemap in tilemaps:
		tilemap.enabled = state
	background.visible = state
	self.process_mode = Node.PROCESS_MODE_INHERIT if state else Node.PROCESS_MODE_DISABLED
