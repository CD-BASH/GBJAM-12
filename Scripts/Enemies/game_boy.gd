extends Node2D

signal first_flash
signal second_flash
signal final_flash
signal game_boy_start
signal game_boy_off

## Total time that you want the level to be.
@export var total_time = 9
@export var num_switch_needed: int = 0

@onready var first_clic = $Timer/FirstClic
@onready var second_clic = $Timer/SecondClic
@onready var final_clic = $Timer/FinalClic
@onready var timer = $Timer

var num_clics = 0
var wait_time 
var sound_array = []


func _ready():
	game_boy_start.emit()
	sound_array = [first_clic, second_clic, final_clic]
	wait_time = total_time / sound_array.size()
	timer_handler()


func timer_handler() -> void:
	timer.wait_time = wait_time
	timer.start()

func _on_timer_timeout():
	if num_clics < sound_array.size() - 1:
		sound_array[num_clics].play()
		num_clics += 1
		if num_clics == 1:
			first_flash.emit()
		elif num_clics == 2:
			second_flash.emit()
		timer_handler()
	else :
		final_clic.play()
		final_flash.emit()
