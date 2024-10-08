extends Node2D

@export var next_scene_to_load: PackedScene = null

@onready var opening_transition_screen: CanvasLayer = $OpeningTransitionScreen
@onready var closing_transition_screen: CanvasLayer = $ClosingTransitionScreen
@onready var gameboy_entity_face: AnimatedSprite2D = $GameboyEntityFace
@onready var dialogue: CanvasLayer = $Dialogue

var started_second_sequence = false

func _ready() -> void:
	MusicPlayer.select_track(4)
	MusicPlayer.play()
	opening_transition_screen.play_transition_screen()
	gameboy_entity_face.idle()
	first_sequence()

func _process(delta: float) -> void:
	if dialogue.dialogue_is_done and !started_second_sequence:
		started_second_sequence = true
		second_sequence()

func first_sequence() -> void:
	await get_tree().create_timer(2.0).timeout
	gameboy_entity_face.idle_left()
	await get_tree().create_timer(2.0).timeout
	dialogue.dialogue_is_in_process = true
	gameboy_entity_face.speak_left()
	
	

func second_sequence() -> void:
	gameboy_entity_face.idle()
	closing_transition_screen.play_transition_screen()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_packed(next_scene_to_load)
	MusicPlayer.stop()
