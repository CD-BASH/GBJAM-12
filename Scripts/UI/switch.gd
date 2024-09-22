extends Area2D

signal turn_on
@onready var animated_sprite_2d = $AnimatedSprite2D
var is_on = true
var game_boy_entity

func _enter_tree():
	game_boy_entity = get_tree().get_first_node_in_group("gameboy_entity")
	
func _on_body_entered(body):
	if is_on:
		game_boy_entity.switch_signal()
		animated_sprite_2d.frame = 1
		is_on = false
	
