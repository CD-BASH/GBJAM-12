extends Node2D

@onready var left_raycast = $left_raycast
@onready var right_raycast = $right_raycast
@onready var up_raycast = $up_raycast
@onready var down_raycast = $down_raycast
@onready var seen_sound = $seen_sound
@onready var timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#variables in the inspector choose the direction that can see the player
@export_group("Raycast direction")
@export var angle: int = 0
@export_group("Enemy Type")
@export var enemy: EnemyChoice


var raycast_chosen
var gameboy_entity
var grid_level

enum EnemyChoice
{
	GAMION_SIDE,
	GAMION_TOP	
}

func _enter_tree() -> void:
	gameboy_entity = get_tree().get_first_node_in_group("gameboy_entity")
	grid_level = get_tree().get_first_node_in_group("grid_level")
	if gameboy_entity != null:
		gameboy_entity.first_flash.connect(chose_angle)
		gameboy_entity.second_flash.connect(chose_angle)
		gameboy_entity.final_flash.connect(chose_angle)

func _ready():
	change_enemy_animation()
	
func chose_angle():
	match angle:
		0:
			raycast_chosen = up_raycast
		90:
			raycast_chosen = right_raycast
		180:
			raycast_chosen = down_raycast
		270:
			raycast_chosen = left_raycast
		_:
			print("not the angle")
	
	raycast_chosen.enabled = true
	raycast_chosen.visible = true
	timer.start(0.2)

func change_enemy_animation():
	match enemy:
		EnemyChoice.GAMION_SIDE:
			animated_sprite_2d.play("gamion_side")
		EnemyChoice.GAMION_TOP:
			animated_sprite_2d.play("gamion_top")
	
func _process(_delta):
	if raycast_chosen != null and raycast_chosen.is_colliding():
		#debbugging feature can be erase 
		print("I SEE YOU!")
		
		#play sound when seen
		seen_sound.play()
		grid_level.level_failed()
		#code here when the player is seen
		
		
func _on_timer_timeout():
	raycast_chosen.enabled = false
	raycast_chosen.visible = false
