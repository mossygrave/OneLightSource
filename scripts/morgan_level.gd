extends Node3D

@onready var light_path1: Node3D = $Node3D/LightPath
@onready var anim_door: Node3D = $Node3D/anim_door

@onready var light_path2: Node3D = $TestMechanism/LightPath
@onready var anim_door2: Node3D = $anim_door

@onready var light_path3: Node3D = $TestMechanism2/LightPath
@onready var anim_door_3: Node3D = $Node3D/anim_door2
@onready var door: Node3D = $TestMechanism2/LightPath/Door
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_test_mechanism_tower_lit() -> void:
	light_path1.visible = true
	anim_door.open_door()


func _on_test_mechanism_tower_lit2() -> void:
	light_path2.visible = true
	anim_door2.open_door()
	

func _on_test_mechanism_2_tower_lit3() -> void:
	light_path3.visible = true
	anim_door_3.open_door()
