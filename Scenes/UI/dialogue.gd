extends CanvasLayer

@export var messages: Array

@onready var arrow: TextureRect = $Control/Arrow
@onready var label: Label = $Control/Label

var message_index = 0
var arrow_is_visible = true
var listen_input = true
var dialogue_is_in_process = false
var dialogue_is_done = false
var first_line = true

func _process(delta: float) -> void:
	if dialogue_is_in_process:
		if arrow_is_visible:
			blink_arrow()
		
		if first_line or listen_input && Input.is_action_just_pressed("a_btn"):
			if message_index < messages.size():
				print_label(messages[message_index])
				first_line = false
				message_index += 1
			else:
				hide_dialogue()
				arrow.visible = false
				arrow_is_visible = false
				dialogue_is_in_process = false
				dialogue_is_done = true


func print_label(message):
	label.text = str(message)

func blink_arrow():
	arrow_is_visible = false
	arrow.visible = false
	await get_tree().create_timer(0.5).timeout
	arrow.visible = !dialogue_is_done
	await get_tree().create_timer(0.5).timeout
	arrow_is_visible = true

func hide_dialogue():
	label.visible = false
	arrow.visible = false
