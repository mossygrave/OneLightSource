extends Node3D

@onready var open: Marker3D = $Open
@onready var closed: Marker3D = $Closed
@onready var door: Node3D = $Door
@onready var light_path: Node3D = $LightPath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door.global_position = closed.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_test_mechanism_tower_lit() -> void:
	change_door()
	
	
func change_door():
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	var open_pos = open.global_position

	if door.global_position != open_pos:
		light_path.visible = true
		tween.tween_property(door, "global_position", open_pos, 3)
		await get_tree().create_timer(3.1).timeout
		door.collision_state()
