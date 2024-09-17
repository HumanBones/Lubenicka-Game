extends CharacterBody2D

@export var max_speed : float
@export var move_treshold : float = 20.0

@onready var speed = max_speed
@onready var wall = $"../Walls/Wall"
@onready var wall_2 = $"../Walls/Wall2"
@onready var offset_pos :float = 32.0

var direction : float
var mouse_pos : Vector2
var mouse_dir_x : float = 0.0
var is_key_mode : bool = false
var is_game_over : bool = false

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = get_viewport().get_mouse_position()
		is_key_mode = false
		
		
func _process(delta):
	if is_game_over:
		return
		
	direction = 0.0
	
	global_position.x = clamp(global_position.x,wall.global_position.x + offset_pos, wall_2.global_position.x - offset_pos)
	
	var key_direction = Input.get_axis("left","right")
	
	if key_direction:
		is_key_mode = true
	
	
	if key_direction != 0 && is_key_mode:
		direction = key_direction
	if !is_key_mode:
		global_position.x = move_toward(global_position.x, mouse_pos.x,delta * speed)
		
	velocity.x = direction * speed
	
	move_and_slide()
	



func _on_walls_game_over():
	is_game_over = true
