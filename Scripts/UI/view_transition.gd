extends CanvasLayer

signal switch_view

@export var top_sound: AudioStream
@export var side_sound: AudioStream

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func top_view_transition():
	animation_player.play("top_view_swipe")
	play_transition_sound(top_sound)

func side_view_transition():
	animation_player.play("side_view_swipe")
	play_transition_sound(side_sound)

func play_transition_sound(sound: AudioStream):
	audio_stream_player.stream = sound
	audio_stream_player.play()

func switch_view_trigger():
	switch_view.emit()
