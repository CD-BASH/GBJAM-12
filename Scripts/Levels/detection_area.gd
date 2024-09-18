extends Area2D

@export var area_type := AreaType.DEPTH_PUSH
@export_range(0, 9, 0.5) var area_depth_push_value := 4.5
@export_range(0, 9, 0.5) var area_altitude_push_value := 4.5

var grid_level: Node2D
var collider: CollisionShape2D

enum AreaType {
	DEPTH_PUSH,
	ALTITUDE_PUSH,
	SAFE_ZONE_DEPTH,
	SAFE_ZONE_ALTITUDE
}


func _ready() -> void:
	grid_level = get_tree().get_first_node_in_group("grid_level")


#region Signals
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		match area_type:
			AreaType.DEPTH_PUSH:
				grid_level.player_depth = area_depth_push_value
			AreaType.ALTITUDE_PUSH:
				grid_level.player_altitude = area_altitude_push_value
			AreaType.SAFE_ZONE_DEPTH:
				grid_level.track_safe_zone_depth(true)
			AreaType.SAFE_ZONE_ALTITUDE:
				grid_level.track_safe_zone_altitude(true)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		match area_type:
			AreaType.SAFE_ZONE_DEPTH:
				grid_level.track_safe_zone_depth(false)
			AreaType.SAFE_ZONE_ALTITUDE:
				grid_level.track_safe_zone_altitude(false)
#endregion
