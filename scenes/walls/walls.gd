extends Node2D

signal game_over


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("fruits"):
		game_over.emit()
		
