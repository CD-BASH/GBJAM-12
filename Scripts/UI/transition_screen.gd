extends CanvasLayer

@export var transition_color: Color = Color.WHITE
@export var animation_type := AnimationType.DISOLVE_COLOR

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

enum AnimationType {
	DISOLVE_COLOR,
	DISOLVE_CONTENT,
	SWIPE_COLOR,
	SWIPE_CONTENT,
}

func _ready() -> void:
	play_transition_screen()

func play_transition_screen() -> void:
	animated_sprite_2d.modulate = transition_color;
	
	match animation_type:
		AnimationType.DISOLVE_COLOR:
			animated_sprite_2d.play("disolve_color")
		AnimationType.DISOLVE_CONTENT:
			animated_sprite_2d.play("disolve_content")
		AnimationType.SWIPE_COLOR:
			animated_sprite_2d.play("swipe_color")
		AnimationType.SWIPE_CONTENT:
			animated_sprite_2d.play("swipe_content")
