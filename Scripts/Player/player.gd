extends CharacterBody2D
class_name Player

@export var player_coordinate: Vector3
@export var player_control_type := PlayerControlTypes.SIDE_VIEW
@export var movement_speed := 100.0
@export_subgroup("Side View")
@export var gravity := 300.0
@export var jump_force := 150.0
@export var side_collision_shape: RectangleShape2D
@export_subgroup("Top View")
@export var top_collision_shape: RectangleShape2D
@export_subgroup("Down View")
@export var down_collision_shape: RectangleShape2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


enum PlayerControlTypes
{
	SIDE_VIEW,
	TOP_VIEW,
	DOWN_VIEW
}


func _physics_process(delta: float) -> void:
	match player_control_type:
		PlayerControlTypes.SIDE_VIEW:
			side_movement(delta)
			collision_shape_2d.shape = side_collision_shape
		PlayerControlTypes.TOP_VIEW:
			top_down_view_movement(delta, true)
			collision_shape_2d.shape = top_collision_shape
		PlayerControlTypes.DOWN_VIEW:
			top_down_view_movement(delta, false)
			collision_shape_2d.shape = down_collision_shape


func side_movement(delta) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 400.0:
			velocity.y = 400
	
	if Input.is_action_just_pressed("up_dPad") && is_on_floor():
		velocity.y = -jump_force
	
	var direction = Input.get_axis("left_dPad","right_dPad")
	
	if direction != 0:
		animated_sprite_2d.play("side_walk")
		animated_sprite_2d.flip_h = (direction == -1)
	else:
		animated_sprite_2d.play("side_idle")
	
	velocity.x = direction * movement_speed
	move_and_slide()
 

func top_down_view_movement(delta, top_view: bool) -> void:
	var horizontal_direction = Input.get_axis("left_dPad", "right_dPad")
	var vertical_direction = Input.get_axis("up_dPad", "down_dPad")
	
	velocity.x = horizontal_direction * movement_speed
	velocity.y = vertical_direction * movement_speed
	
	if velocity.x != 0 or velocity.y != 0:
		var animation_name = "top_walk" if top_view else "down_walk"
		animated_sprite_2d.flip_h = (horizontal_direction == -1)
		animated_sprite_2d.play(animation_name)
	else:
		var animation_name = "top_idle" if top_view else "down_idle"
		animated_sprite_2d.play(animation_name)
	
	move_and_slide()
