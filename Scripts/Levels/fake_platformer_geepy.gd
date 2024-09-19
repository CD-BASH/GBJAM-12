extends Node2D

@onready var player = $Player
@onready var side_view: Node2D = $SideView
@export var starting_view := ViewMode.SIDE_VIEW

enum ViewMode
{
	SIDE_VIEW
}
func _ready():
	side_view.activate_view(true)
	player.player_control_type = ViewMode.SIDE_VIEW


func _process(delta):
	pass
