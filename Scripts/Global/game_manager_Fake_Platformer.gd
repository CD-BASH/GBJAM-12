extends Node

var score = 0
@onready var score_text = $CanvasLayer/Score

func add_point():
	score += 1
	score_text.text = "Score: " + str(score)
