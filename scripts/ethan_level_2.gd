extends Node3D

var door1_open = false
var show_prompt = true
var is_in_area = true
@onready var anim_door: Node3D = $Doors/anim_door


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.tower_has_light == false
	#$LightPath.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	level_success()
	if door1_open == true:
		#$LightPath.show()
		anim_door.open_door()

func level_success():
	if global.tower_has_light == true:
		global.lvl_one_solved = true
		door1_open = true
