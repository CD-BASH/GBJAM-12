extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var dead = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if !dead:
			die()

func die() -> void:
	animated_sprite_2d.play("die")
	audio_stream_player.play()
	await animated_sprite_2d.animation_finished
	queue_free()
