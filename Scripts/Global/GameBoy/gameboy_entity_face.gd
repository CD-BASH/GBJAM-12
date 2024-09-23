extends AnimatedSprite2D




func idle() -> void:
	self.play("idle")

func idle_left() -> void:
	self.play("idle_left")

func speak_left() -> void:
	self.play("speak_left")

func search() -> void: 
	self.play("search")

func found() -> void: 
	self.play("found")
