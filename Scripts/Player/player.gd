extends CharacterBody2D
class_name Player


@export var player_control_type := PlayerControlTypes.SIDE_VIEW
@export var movement_speed := 100.0
@export_subgroup("Side View")
@export var gravity := 300.0
@export var jump_force := 150.0
@export var fall_force := 150.0
@export var side_collision_shape: RectangleShape2D
@export_subgroup("Top View")
@export var top_collision_shape: RectangleShape2D
@export_subgroup("Down View")
@export var down_collision_shape: RectangleShape2D
@export var controle_view: PlayerControlTypes
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var can_move := true
var is_spawn = false
var is_dead = false

enum PlayerControlTypes
{
	SIDE_VIEW,
	TOP_VIEW,
	DOWN_VIEW
}

func _ready() -> void:
	player_control_type = PlayerControlTypes.SIDE_VIEW
	spawn()

func _physics_process(delta: float) -> void:
	if is_spawn && !is_dead:
		match player_control_type:
			PlayerControlTypes.SIDE_VIEW:
				side_view_movement(delta)
				collision_shape_2d.shape = side_collision_shape
			PlayerControlTypes.TOP_VIEW:
				top_down_view_movement(delta, true)
				collision_shape_2d.shape = top_collision_shape
			PlayerControlTypes.DOWN_VIEW:
				top_down_view_movement(delta, false)
				collision_shape_2d.shape = down_collision_shape

func spawn():
	match player_control_type:
		PlayerControlTypes.SIDE_VIEW:
			animated_sprite_2d.play("spawn_side")
		PlayerControlTypes.TOP_VIEW:
			animated_sprite_2d.play("spawn_top")
	await animated_sprite_2d.animation_finished
	is_spawn = true

func jump_animation():
	animated_sprite_2d.play("jump")

func death():
	is_dead = true
	match player_control_type:
		PlayerControlTypes.SIDE_VIEW:
			animated_sprite_2d.play("death_side")
		PlayerControlTypes.TOP_VIEW:
			animated_sprite_2d.play("death_top")

func side_view_movement(delta) -> void:
	var direction = 0.0
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 900.0:
			velocity.y = 900
			
	if can_move:
		direction = Input.get_axis("left_dPad","right_dPad")
		if is_on_floor():
			if Input.is_action_just_pressed("up_dPad"):
				velocity.y = -jump_force
			if direction == 0:
				animated_sprite_2d.play("side_idle")
			else:
				animated_sprite_2d.play("side_walk")
		else:
			if velocity.y < 0:
				animated_sprite_2d.play("jump_up")
			else:
				animated_sprite_2d.play("jump_down")
				
	if direction != 0:
		animated_sprite_2d.flip_h = (direction == -1)
	
	velocity.x = direction * movement_speed
	move_and_slide()
 

func top_down_view_movement(_delta, top_view: bool) -> void:
	var horizontal_direction = 0.0
	var vertical_direction = 0.0
	
	if can_move:
		horizontal_direction = Input.get_axis("left_dPad", "right_dPad")
		vertical_direction = Input.get_axis("up_dPad", "down_dPad")
	
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
