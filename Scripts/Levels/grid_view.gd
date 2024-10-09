extends Node2D

@export var background: ParallaxBackground
@export var tilemaps: Array[TileMapLayer]
@export var wait_for_player_position := false

func activate_view(state: bool):
	visible = state
	for i in tilemaps.size():
		tilemaps[i].enabled = state
	background.visible = state
	if wait_for_player_position && state: await get_tree().create_timer(0.1).timeout
	self.process_mode = Node.PROCESS_MODE_INHERIT if state else Node.PROCESS_MODE_DISABLED
