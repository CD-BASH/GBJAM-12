extends Node2D


@onready var canvas_dialogue = $canvas_dialogue
var messages = []

func _ready():
	messages = ["You little ghost is not welcome here leave immediatly!","I'M gonna kick you out!!! NOW!!!"]
	canvas_dialogue.show_text(messages, 0.1)

func _process(delta):
	pass
