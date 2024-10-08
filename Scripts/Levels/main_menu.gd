extends Control

@export var next_scene: PackedScene = null

@onready var start_label: Label = $Start_Label
@onready var transition_screen: CanvasLayer = $TransitionScreen
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var blink = true
var pressed = false


func _ready() -> void:
	MusicPlayer.select_track(0)
	MusicPlayer.play()

func _process(delta: float) -> void:
	if !pressed:
		if Input.is_action_just_pressed("a_btn") or Input.is_action_just_pressed("start_btn") or Input.is_action_just_pressed("select_btn"):
			pressed = true
			transition_screen.play_transition_screen()
			audio_stream_player.play()
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_packed(next_scene)
	
	if blink:
		blink_start()


func blink_start():
	blink = false
	await get_tree().create_timer(0.5).timeout
	start_label.visible = true
	await get_tree().create_timer(0.5).timeout
	start_label.visible = false
	blink = true
