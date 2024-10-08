extends Control

@export var next_scene: PackedScene = null

@onready var godot: TextureRect = $Godot
@onready var jameux: TextureRect = $Jameux
@onready var opening_transition_screen: CanvasLayer = $OpeningTransitionScreen
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	godot.visible = false
	jameux.visible = false
	splash_sequence()


func splash_sequence() -> void:
	await get_tree().create_timer(0.5).timeout
	opening_transition_screen.play_transition_screen()
	godot.visible = true
	audio_stream_player.play()
	await get_tree().create_timer(3.0).timeout
	godot.visible = false
	opening_transition_screen.play_transition_screen()
	jameux.visible = true
	audio_stream_player.play()
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_packed(next_scene)
