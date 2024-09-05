extends RigidBody2D

signal collided(pos:Vector2)

@export var fruit_type : FruitHolder.F_TYPE
@onready var sprite_2d = $Sprite2D


var spawn_pos : Vector2


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("fruits"):
		if area.get_parent().fruit_type == fruit_type:
			if not area.get_parent().has_meta("collision_handled") and not self.has_meta("collision_handled"):
				area.get_parent().set_meta("collision_handled", true)
				self.set_meta("collision_handled", true)
				spawn_pos = (global_position + area.get_parent().global_position)/2
				collided.emit(spawn_pos,fruit_type)
				#call_deferred("call_singal_collided",spawn_pos,fruit_type)
				area.get_parent().call_deferred("queue_free")
				call_deferred("queue_free")
			
func call_singal_collided(spawn_pos,fruit_type) ->void:
	collided.emit(spawn_pos,fruit_type)

