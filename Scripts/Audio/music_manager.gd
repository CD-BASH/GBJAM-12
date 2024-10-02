extends Node

@export var music_to_play: AudioStream
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func play_music(music: AudioStream):
	audio_stream_player.stream = music
	audio_stream_player.play()
