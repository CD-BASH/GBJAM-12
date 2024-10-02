extends Area2D

@onready var game_manager = %GameManager
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(body):
	game_manager.add_point()
	audio_stream_player.play()
	self.visible = false
	await get_tree().create_timer(0.2).timeout
	queue_free()
