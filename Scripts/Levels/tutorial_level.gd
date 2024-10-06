extends Node2D

@export var next_scene_to_load: PackedScene = null

@onready var arrow: TextureRect = $Control/Arrow
@onready var opening_transition_screen: CanvasLayer = $OpeningTransitionScreen
@onready var closing_transition_screen: CanvasLayer = $ClosingTransitionScreen


var arrow_is_visible = true

func _ready() -> void:
	opening_transition_screen.play_transition_screen()

func _process(delta: float) -> void:
	if arrow_is_visible:
		blink_arrow()
	
	if Input.is_action_just_pressed("a_btn"):
		closing_transition_screen.play_transition_screen()
		await get_tree().create_timer(1.0)
		MusicPlayer.select_track(2)
		get_tree().change_scene_to_packed(next_scene_to_load)

func blink_arrow():
	arrow.visible = false
	arrow_is_visible = false
	await get_tree().create_timer(0.5).timeout
	arrow.visible = true
	await get_tree().create_timer(0.5).timeout
	arrow_is_visible = true
