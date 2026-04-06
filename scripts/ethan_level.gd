extends Node3D

var door1_open = false
var show_prompt = true
var is_in_area = true
@onready var anim_door: Node3D = $anim_door
@onready var anim_door_2: Node3D = $anim_door2
@onready var collision_shape_3d: CollisionShape3D = $Lantern/StaticBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.tower_has_light == false
	$Player/DimVision.show()
	$Player/Head.hide()
	$Player/Head.hide()
	$Player/Head/SubViewportContainer/SubViewport/Lantern.hide()
	$Lantern/PickUpLantern/PickUpPrompt.hide()
	$LightPath.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_in_area == true and Input.is_action_just_pressed("lantern_give"):
		global.lantern_obtained = true
	if global.lantern_obtained == true:
		$Player/DimVision.hide()
		$Player/Head.show()
		$Player/Head.show()
		$Player/Head/SubViewportContainer/SubViewport/Lantern.show()
		$Lantern/PickUpLantern/PickUpPrompt.hide()
		$Lantern.hide()
		collision_shape_3d.disabled = true
		show_prompt = false
		anim_door_2.open_door()
	level_success()
	if door1_open == true:
		$LightPath.show()
		anim_door.open_door()

func level_success():
	if global.tower_has_light == true:
		global.lvl_one_solved = true
		door1_open = true


func _on_pick_up_area_body_entered(_body: CharacterBody3D) -> void:
	is_in_area = true
	if show_prompt == true:
		$Lantern/PickUpLantern/PickUpPrompt.show()


func _on_pick_up_area_body_exited(_body: CharacterBody3D) -> void:
	is_in_area = false
	$Lantern/PickUpLantern/PickUpPrompt.hide()
