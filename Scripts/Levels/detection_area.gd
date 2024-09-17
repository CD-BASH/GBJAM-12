extends Area2D

@export var area_type := AreaType.DEPTH_PUSH
@export_range(0, 8, 0.5) var area_depth_push_value := 4.5
@export_range(0, 8, 0.5) var area_altitude_push_value := 4.5

var grid_level: Node2D
var collider: CollisionShape2D

enum AreaType {
	DEPTH_PUSH,
	ALTITUDE_PUSH,
	SAFE_ZONE
}


func _ready() -> void:
	grid_level = get_tree().get_first_node_in_group("grid_level")


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		match area_type:
			AreaType.DEPTH_PUSH:
				grid_level.player_depth = area_depth_push_value
			AreaType.ALTITUDE_PUSH:
				grid_level.player_depth = area_altitude_push_value
