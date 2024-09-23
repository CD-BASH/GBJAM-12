extends CharacterBody2D
class_name Player

@export var spawn_animation_on_start := true
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
@onready var coyote_timer : Timer = $CoyoteTimer

@export_subgroup("JumpParameter")
@export var max_jump_height = 5.0
@export var gravity_multiplier_at_apex = 3.0
@export var gravity_exponent = 3.0

## sounds 
@onready var jump_sound = $Jump

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
	if spawn_animation_on_start:
		spawn()
	else:
		is_spawn = true

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

func adjusted_gravity() -> float:
	var apex_proximity = clamp(abs(velocity.y) / max_jump_height, 0.0, 1.0)
	return gravity * lerp(1.0, gravity_multiplier_at_apex, pow(apex_proximity, gravity_exponent))

func side_view_movement(delta) -> void:
	var direction = 0.0
	if !is_on_floor():
		velocity.y += adjusted_gravity() * delta
		if velocity.y > 900.0:
			velocity.y = 900
	
	if can_move:
		direction = Input.get_axis("left_dPad","right_dPad")
		
		## jump
		if Input.is_action_just_pressed("up_dPad") and (is_on_floor() or !coyote_timer.is_stopped()):
			velocity.y = -jump_force
			jump_sound.pitch_scale = randf_range(0.9,1.1)
			jump_sound.play()
		
		if is_on_floor():
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
	
	var was_on_the_floor = is_on_floor()
	move_and_slide()
	if was_on_the_floor && !is_on_floor():
		print_debug("not on the floor anymore")
		coyote_timer.start()
 

func top_down_view_movement(delta, top_view: bool) -> void:
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
