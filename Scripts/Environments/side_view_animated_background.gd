extends ParallaxBackground

@export_category("Starting Parameters")
@export var starting_scroll_speed = 15
@export var starting_scroll_direction = Vector2(0.1, 1)
@export var starting_bg_texture: CompressedTexture2D
@export_category("First Flash")
@export var first_flash_scroll_speed = 15
@export var first_flash_scroll_direction = Vector2(0.1, 1)
@export var first_flash_bg_texture: CompressedTexture2D
@export_category("Second Flash")
@export var second_flash_scroll_speed = 15
@export var second_flash_scroll_direction = Vector2(0.1, 1)
@export var second_flash_bg_texture: CompressedTexture2D
@export_category("Final Flash")
@export var final_flash_scroll_speed = 15
@export var final_flash_scroll_direction = Vector2(0.1, 1)
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
		gameboy_entity.game_boy_start.connect(_ready)

func _ready() -> void:
	scroll_speed = starting_scroll_speed
	scroll_direction = starting_scroll_direction
	sprite.texture = starting_bg_texture

func _process(delta):
	sprite.region_rect.position += delta * scroll_direction * scroll_speed


func first_flash_effect():
	scroll_speed = first_flash_scroll_speed
	scroll_direction = first_flash_scroll_direction
	sprite.texture = first_flash_bg_texture

func second_flash_effect():
	scroll_speed = second_flash_scroll_speed
	scroll_direction = second_flash_scroll_direction
	sprite.texture = second_flash_bg_texture

func final_flash_effect():
	scroll_speed = final_flash_scroll_speed
	scroll_direction = final_flash_scroll_direction
	sprite.texture = final_flash_bg_texture
