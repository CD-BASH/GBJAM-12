extends Node2D

@export var background: ParallaxBackground
@export var tilemaps: Array[TileMapLayer]

func activate_view(state: bool):
	visible = state
	print(tilemaps)
	for i in tilemaps.size():
		tilemaps[i].enabled = state
		print("Hi")
	background.visible = state
	self.process_mode = Node.PROCESS_MODE_INHERIT if state else Node.PROCESS_MODE_DISABLED
