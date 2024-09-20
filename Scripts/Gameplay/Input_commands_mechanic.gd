extends Node2D


@export var UP_Dpad: TextureRect
@export var down_pad1: TextureRect
@export var left_pad1: TextureRect
@export var right_pad1: TextureRect

@onready var up_dpad = $Arrows/up_dpad
@onready var down_dpad = $Arrows/down_dpad
@onready var right_dpad = $Arrows/right_dpad
@onready var left_dpad = $Arrows/left_dpad

@onready var screen_container = $CanvasLayer/image_container
@export var number_arrow: int

#Base array of the four arrow direction
var array_arrow = []
#max number of arrow in the array_arrow
const index_arrow = 3
#All the input in a random order array
var input_array = []
#index of the current array of image on the screen
var index_Current_array = 0
#String to identify what arrow is press compare to the metadata 
var current_arrow = ""
#if the arrows are on screen
var is_arrow_on_Screen = false

func _ready():
	initialize_arrow_array()
	random_arrow_array(number_arrow)
	show_arrow_to_screen()
	
func _process(delta):
	if is_arrow_on_Screen:
		if Input.is_action_just_pressed("up_dPad"):
			current_arrow = "UP"
		if Input.is_action_just_pressed("down_dPad"):
			current_arrow = "DOWN"
		if Input.is_action_just_pressed("left_dPad"):
			current_arrow = "LEFT"
		if Input.is_action_just_pressed("right_dPad"):
			current_arrow = "RIGHT"
		if  index_Current_array != screen_container.get_child_count():
			#if the input is equal to the dpad on the screen 
			var first_image = screen_container.get_child(index_Current_array)
			if first_image.get_meta("arrow_type") == current_arrow :
				current_arrow = ""
				print("Correct arrow")
				first_image.visible = false
				index_Current_array += 1
			elif current_arrow != "":
				print("wrong arrow")
				current_arrow = ""
				index_Current_array = 0
				show_arrow_to_screen()
					
				

func random_arrow_array(num_input: int):
	for i in range(num_input):
		var random_num = randi_range(0, 3)
		#make a variables duplicate
		var duplicate_arrow = array_arrow[random_num].duplicate()
		
		#switch to set the metadata to each arrow
		match random_num:
			0:
				#firste the type and second the name of the type
				duplicate_arrow.set_meta("arrow_type", "UP")
			1:
				duplicate_arrow.set_meta("arrow_type", "DOWN")
			2:
				duplicate_arrow.set_meta("arrow_type", "RIGHT")
			3:
				duplicate_arrow.set_meta("arrow_type", "LEFT")
		#add the duplicate to the array
		input_array.append(duplicate_arrow)

func show_arrow_to_screen():
	#make all the arrow on the screen visible again
	for i in range(input_array.size()):
		input_array[i].visible = true
		screen_container.add_child(input_array[i])
		
	is_arrow_on_Screen = true
	
func initialize_arrow_array():
		#initialize the arrow array
	array_arrow.append(UP_Dpad)
	array_arrow.append(down_pad1)
	array_arrow.append(right_pad1)
	array_arrow.append(left_pad1)
	
