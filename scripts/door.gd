extends Node3D

#signal door_entered
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	get_tree().change_scene_to_file("res://scenes/test_level.tscn")
	#door_entered.emit()

func collision_state():
	if collision_shape_3d.disabled:
		collision_shape_3d.disabled = false
	else:
		collision_shape_3d.disabled = true
