extends Node2D

@onready var left_raycast = $left_raycast
@onready var right_raycast = $"right-raycast"
@onready var top_raycast = $top_raycast
@onready var down_raycast = $down_raycast


func _ready():
	pass 


func _process(delta):
	pass

#funtion to implement in level script
func chose_raycast_direction(direction: string):
	
