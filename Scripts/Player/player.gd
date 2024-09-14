extends CharacterBody2D

@export var player_control_type := PlayerControlTypes.SIDE_VIEW
@export var movement_speed := 100.0
@export_subgroup("Side View")
@export var gravity := 300.0
@export var jump_force := 150.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

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
		PlayerControlTypes.TOP_VIEW:
			top_view_movement(delta)


func side_movement(delta) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 400.0:
			velocity.y = 400
	
	if Input.is_action_just_pressed("up_dPad") && is_on_floor():
		velocity.y = -jump_force
	
	var direction = Input.get_axis("left_dPad","right_dPad")
	
	if direction != 0:
		animated_sprite_2d.flip_h = (direction == -1)
	
	velocity.x = direction * movement_speed
	move_and_slide()
 

func top_view_movement(delta) -> void:
	var horizontal_direction = Input.get_axis("left_dPad", "right_dPad")
	var vertical_direction = Input.get_axis("ui_up", "down_dPad")
	
	velocity.x = horizontal_direction * movement_speed
	velocity.y = vertical_direction * movement_speed
	
	move_and_slide()
	
	
	
