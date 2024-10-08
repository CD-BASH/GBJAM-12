extends AudioStreamPlayer

@export var spooky_town_music: AudioStream
@export var spooky_town_glitch_music: AudioStream
@export var grid_music: AudioStream
@export var grid_glitch_music: AudioStream
@export var question_mark_music: AudioStream
@export_category("Grif Music Sections")
@export var grid_music_sections: Array[float]

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
		4: 
			stream = question_mark_music

func pause_grid_music():
	pause_position = get_playback_position()
	stop()

func resume_grid_music():
	if !playing:
		if pause_position == 0:
			pause_position = grid_music_sections[0]
		elif pause_position <= grid_music_sections[1]:
			pause_position = grid_music_sections[1]
		elif pause_position <= grid_music_sections[2]:
			pause_position = grid_music_sections[2]
		elif pause_position <= grid_music_sections[3]:
			pause_position = grid_music_sections[3]
		else:
			pause_position = grid_music_sections[0]
		
		play(pause_position)
