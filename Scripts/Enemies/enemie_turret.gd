extends Node2D

@onready var left_raycast = $left_raycast
@onready var right_raycast = $right_raycast
@onready var up_raycast = $up_raycast
@onready var down_raycast = $down_raycast
@onready var seen_sound = $seen_sound
#@onready var timer = $Timer

#variables in the inspector choose the direction that can see the player
@export_group("Raycast direction")
@export var right = false
@export var left = false
@export var down = false
@export var up = false

#if we want the player to be seen only once
var player_seen = false

func _ready():
	chose_raycast_direction()

func _process(delta):
	if (left_raycast.is_colliding() || right_raycast.is_colliding() || up_raycast.is_colliding() || down_raycast.is_colliding()) && !player_seen:
		#debbugging feature can be erase 
		print("I SEE YOU!")
		
		#play sound when seen
		seen_sound.play()
		#variable to be seen only once
		player_seen = true
		
		#code here when the player is seen
		
		
		
		#add the timer to be seen multiple times
		#timer.wait_time = 1
		#timer.start()
		

func chose_raycast_direction() -> void:
	if right:
		right_raycast.enabled = true
	if left:
		left_raycast.enabled = true
	if down:
		down_raycast.enabled = true
	if up:
		up_raycast.enabled = true
	

#func _on_timer_timeout():
#	player_seen = false
