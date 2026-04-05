extends Node3D
var show_prompt = false

@onready var is_in_area = false # Local variable that says if the user is in the area -Mo
@onready var lit: bool = false # Is the tower lit

signal tower_lit

# HIDE LIGHT AT START
func _ready() -> void:
	$MechanismLight.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# Handle Text Pop-Up for Lantern Interaction
	if show_prompt == false and is_in_area == true:
		$Prompt.show()
	else:
		$Prompt.hide()

	# Handle GIVE LIGHT for this object \\\\ ---> Fix for duplicates? # Fixed! -Mo
	if Input.is_action_just_pressed("lantern_give") and is_in_area == true:
		# Because is_player_in_area is global and a bool, being in one area will count for all of them 
		# I changed it so that it is a local variable rather than a global one -Mo
		global.player_has_light = false
		$MechanismLight.show()
		$Prompt.hide()
		show_prompt = false
		lit = true
		tower_lit.emit()

	# Handle RETRIEVE LIGHT for this object \\\\ ---> Fix for duplicates? # Fixed! -Mo
	elif Input.is_action_just_pressed("lantern_take") and is_in_area == true:
		global.player_has_light = true
		$MechanismLight.hide()
		lit = false
		tower_lit.emit() #this should undo whatever lighting the tower does

func _on_trigger_area_body_entered(_body: CharacterBody3D) -> void:
	is_in_area = true
	global.is_player_in_area = true

func _on_trigger_area_body_exited(_body: CharacterBody3D) -> void:
	$Prompt.hide()
	is_in_area = false
	global.is_player_in_area = false
