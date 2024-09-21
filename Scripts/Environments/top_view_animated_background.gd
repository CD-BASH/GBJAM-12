extends ParallaxBackground

@export var starting_bg_texture: CompressedTexture2D
@export var first_flash_bg_texture: CompressedTexture2D
@export var second_flash_bg_texture: CompressedTexture2D
@export var final_flash_bg_texture: CompressedTexture2D

@onready var sprite = $ParallaxLayer/Sprite2D

var gameboy_entity
var scroll_speed
var scroll_direction
var bg_texture


func _enter_tree() -> void:
	gameboy_entity = get_tree().get_first_node_in_group("gameboy_entity")
	if gameboy_entity != null:
		gameboy_entity.first_flash.connect(first_flash_effect)
		gameboy_entity.second_flash.connect(second_flash_effect)
		gameboy_entity.final_flash.connect(final_flash_effect)


func _ready() -> void:
	sprite.texture = starting_bg_texture


func first_flash_effect():
	sprite.texture = first_flash_bg_texture

func second_flash_effect():
	sprite.texture = second_flash_bg_texture

func final_flash_effect():
	sprite.texture = final_flash_bg_texture
