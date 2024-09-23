extends AnimatedSprite2D




func idle() -> void:
	self.play("idle")

func idle_left() -> void:
	self.play("idle_left")

func speak_left() -> void:
	self.play("speak_left")
