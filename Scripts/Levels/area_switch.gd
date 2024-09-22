extends Node2D

var all_contained_areas

func _enter_tree() -> void:
	all_contained_areas = self.get_children()

func switch_areas_process_mode(state: bool) -> void:
	for area in all_contained_areas:
		if state: area.process_mode = Node.PROCESS_MODE_INHERIT
		else: area.process_mode = Node.AUTO_TRANSLATE_MODE_DISABLED
