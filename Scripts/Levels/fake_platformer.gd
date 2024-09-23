extends Node2D

@export var next_scene_to_load: PackedScene = null
@export var glitch_music: AudioStream

@onready var player = $Player
@onready var game_boy_speech: Control = $GameManager/CanvasLayer/GameBoySpeech
@onready var first_transition_screen: CanvasLayer = $Player/FirstTransitionScreen
@onready var second_transition_screen: CanvasLayer = $Player/SecondTransitionScreen
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var level_stopped := false
var sequence_started := false


func _ready() -> void:
	game_boy_speech.visible = false

func _process(delta: float) -> void:
	if level_stopped and !sequence_started:
		end_level_sequence()


func end_level_sequence():
	audio_stream_player.stream = glitch_music
	audio_stream_player.play()
	sequence_started = true
	game_boy_speech.visible = true
	player.can_move = false
	await get_tree().create_timer(2.0).timeout
	player.death()
	await get_tree().create_timer(2.0).timeout
	first_transition_screen.play_transition_screen()
	await get_tree().create_timer(2.0).timeout
	second_transition_screen.play_transition_screen()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_packed(next_scene_to_load)


func _on_level_timer_timeout() -> void:
	level_stopped = true

func _on_end_level_trigger_body_entered(body: Node2D) -> void:
	if body is Player:
		level_stopped = true
