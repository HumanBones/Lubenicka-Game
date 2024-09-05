extends Node2D




func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
