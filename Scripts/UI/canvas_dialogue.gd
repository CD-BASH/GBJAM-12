extends CanvasLayer


@onready var label = $message_text
@onready var letter_timer = $letter_timer
@onready var typing_sound = $AudioStreamPlayer2D
@onready var transition_timer = $transition_timer

#if its in the animation of typing
var is_typing = false
var is_changing_msg = false

#array of different texte message that you want to be 
var text_dialogue = []
var current_char_index = 0

#Speed for the letter to be showed
var typing_speed = 0.1

#ajust this for the time between 
var transition_time = 1


func _ready():
	text_dialogue = []
	transition_timer.wait_time = transition_time
	letter_timer.stop()
	transition_timer.stop()

#when a button is pressed
func _input(event) -> void:
	if event.is_action_pressed("a_btn") || event.is_action_pressed("b_btn"):
		if is_typing:
			is_typing = false
			letter_timer.stop()
			#if the message is not complete show the complet message
			label.text = text_dialogue[0]
			if text_dialogue.size() > 0:
				transition_timer.start()
		else: 
			#if the message is complete and there is another message start the next message animation
			if text_dialogue.size() > 1:
				_on_transition_timer_timeout()		
			else:
				#if there is no other message go to the scene need to be implemented
				#type code here
				print("No more message")
				
				
				
				pass


#in the level script calling this function
func show_text(new_string: Array, speed: float = 0.1):
	if new_string.size() == 0:
		print("no message found!")
		return
	text_dialogue = new_string
	typing_speed = speed
	current_char_index = 0
	label.text = ""
	letter_timer.wait_time = typing_speed
	letter_timer.start()

	
func _on_timer_timeout() -> void:
	if current_char_index < text_dialogue[0].length():
		is_typing = true
		#Update the label for eatch letter
		label.text += text_dialogue[0][current_char_index]
		
		#Only play a sound when its a lettre
		if text_dialogue[0][current_char_index] != " ":
			typing_sound.play()
			
		current_char_index += 1
		letter_timer.start()
	else:
		#When the text is finished stop
		letter_timer.stop()
		is_typing = false
		
		if text_dialogue.size() > 1:
			transition_timer.start()

func _on_transition_timer_timeout() -> void:
	#if text_dialogue.size() > 0:
		text_dialogue.remove_at(0)
		show_text(text_dialogue, typing_speed)
