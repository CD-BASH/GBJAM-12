extends Node2D

@onready var player = $Player
@onready var game_boy_speech: Control = $GameManager/CanvasLayer/GameBoySpeech
@onready var first_transition_screen: CanvasLayer = $Player/FirstTransitionScreen
@onready var second_transition_screen: CanvasLayer = $Player/SecondTransitionScreen

var level_stopped := false
var sequence_started := false

func _ready() -> void:
	game_boy_speech.visible = false

func _process(delta: float) -> void:
	if level_stopped and !sequence_started:
		end_level_sequence()


func end_level_sequence():
	sequence_started = true
	game_boy_speech.visible = true
	player.can_move = false
	await get_tree().create_timer(2.0).timeout
	player.death()
	await get_tree().create_timer(2.0).timeout
	first_transition_screen.play_transition_screen()
	await get_tree().create_timer(2.0).timeout
	second_transition_screen.play_transition_screen()
	

func _on_level_timer_timeout() -> void:
	level_stopped = true

func _on_end_level_trigger_body_entered(body: Node2D) -> void:
	if body is Player:
		level_stopped = true
