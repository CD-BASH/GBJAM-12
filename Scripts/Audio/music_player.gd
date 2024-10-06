extends AudioStreamPlayer

@export var spooky_town_music: AudioStream
@export var spooky_town_glitch_music: AudioStream
@export var grid_music: AudioStream
@export var grid_glitch_music: AudioStream

var pause_position: float

func select_track(track: int):
	match track:
		0:
			stream = spooky_town_music 
		1:
			stream = spooky_town_glitch_music
		2:
			stream = grid_music
		3:
			stream = grid_glitch_music

func pause():
	pause_position = get_playback_position()
	stop()

func resume():
	if !playing:
		play(pause_position)
