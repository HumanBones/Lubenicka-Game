extends Node2D

@export var spawn_cooldown : float = 0.6
@export var score_amount : float = 1.0
@export var multip_time : float = 2.0

@onready var marker_2d = $"../Dropper/Marker2D"
@onready var timer = $Timer
@onready var game_over = $"../CanvasLayer/GameOver"
@onready var next_fruit_img = $"../CanvasLayer/MarginContainer/MarginContainer/VBoxContainer/NextFruit"
@onready var fruit_name = $"../CanvasLayer/MarginContainer/MarginContainer/VBoxContainer/FruitName"
@onready var score_amount_label = $"../CanvasLayer/MarginContainer/ScoreMC/VBoxContainer/ScoreAmount"
@onready var multiplier_timer = $MultiplierTimer
@onready var star_pos: Marker2D = $"../Marker2D"

var dropper_scene = preload("res://scenes/dropper/dropper.tscn")
var player

var can_spawn : bool = true
var is_game_over : bool = false
var next_fruit : int
var next_fruit_inst

func _ready():
	spawn_player()
	ScoreManager.score_updated.connect(update_label)
	multiplier_timer.wait_time = multip_time
	timer.wait_time = spawn_cooldown
	get_next_fruit()
	
	
func _process(delta):
	if is_game_over:
		return
	if Input.is_action_just_pressed("action") and can_spawn:
		spawn_fruit()
		ScoreManager.update_score(score_amount)
		can_spawn = false
		timer.start()
		get_next_fruit()
		

func signal_handler(spawn_pos : Vector2, fruit_type : FruitHolder.F_TYPE) -> void:
	merger(spawn_pos,fruit_type)

func spawn_fruit() ->void:
	if is_game_over:
		return
	var fruit_instance = next_fruit_inst
	fruit_instance.global_position =  marker_2d.global_position
	fruit_instance.collided.connect(signal_handler)
	get_parent().add_child(fruit_instance)


func merger(spawn_pos : Vector2, fruit_type : FruitHolder.F_TYPE) ->void:
	if is_game_over:
		return
	var fruit_instance : Node2D
	if int(fruit_type) >= FruitHolder.fruit_array.size() -1:
		fruit_instance = FruitHolder.fruit_array[-1].instantiate() as Node2D
	else:
		fruit_instance = FruitHolder.fruit_array[(int(fruit_type+1))].instantiate() as Node2D
	fruit_instance.global_position = spawn_pos
	if fruit_instance == null:
		print("null")
		return
	ScoreManager.update_score(score_amount)
	ScoreManager.update_multiplier()
	multiplier_timer.start()
	fruit_instance.collided.connect(signal_handler)
	get_parent().call_deferred("add_child",fruit_instance)


func _on_timer_timeout():
	can_spawn = true


func _on_walls_game_over():
	is_game_over = true
	game_over.show()

func get_next_fruit() ->void:
	next_fruit = randi_range(1,(FruitHolder.fruit_array.size()-1)/2)
	next_fruit_inst = FruitHolder.fruit_array[next_fruit-1].instantiate() as Node2D
	var sprite_node = next_fruit_inst.get_node("Sprite2D") as Sprite2D
	next_fruit_img.texture = sprite_node.texture
	fruit_name.text = next_fruit_inst.name

func update_label(amount : float) ->void:
	score_amount_label.text = str(amount)


func _on_multiplier_timer_timeout():
	ScoreManager.reset_multiplier()


func spawn_player() ->void:
	player = dropper_scene.instantiate()
	player.global_position = star_pos.global_position
