extends Node3D

var door_open = false
@onready var anim_door: Node3D = $anim_door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LightPath.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	level_success()
	if door_open == true:
		$LightPath.show()
		anim_door.open_door()

func level_success():
	if global.tower_has_light == true:
		global.puzzle_solved = true
		door_open = true
