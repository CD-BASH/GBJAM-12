extends Control

@export var next_scene: PackedScene = null

@onready var label_start: Label = $Label_start

var blink = true


func _ready() -> void:
	MusicPlayer.select_track(0)
	MusicPlayer.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("a_btn") or Input.is_action_just_pressed("start_btn") or Input.is_action_just_pressed("select_btn"):
		get_tree().change_scene_to_packed(next_scene)
	
	if blink:
		blink_start()


func blink_start():
	blink = false
	await get_tree().create_timer(0.5).timeout
	label_start.visible = true
	await get_tree().create_timer(0.5).timeout
	label_start.visible = false
	blink = true
