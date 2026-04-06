extends Node3D
var show_prompt1 = false
var show_prompt2 = false

@onready var is_in_area = false # Local variable that says if the user is in the area -Mo
@onready var lit: bool = false # Is the tower lit

signal tower_lit

# HIDE LIGHT AT START
func _ready() -> void:
	$MechanismLight.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# Handle Text Pop-Up for Lantern Interaction
	if show_prompt1 == false and is_in_area == true:
		if global.player_has_light == true:
			$Prompt.show()
			$Prompt2.hide()
	elif show_prompt2 == false and is_in_area == true:
		if global.player_has_light == false:
			$Prompt.hide()
			$Prompt2.show()
	else:
		$Prompt.hide()
		$Prompt2.hide()

	# Handle GIVE LIGHT for this object \\\\ ---> Fix for duplicates? # Fixed! -Mo
	if global.player_has_light == true and Input.is_action_just_pressed("lantern_give") and is_in_area == true:
		# Because is_player_in_area is global and a bool, being in one area will count for all of them 
		# I changed it so that it is a local variable rather than a global one -Mo
		if lit == false:
			print("Lit up mechanism!")
			global.player_has_light = false
			global.tower_has_light = true
			lit = true
			$MechanismLight.show()
			$Prompt.hide()
			$Prompt2.show()
			show_prompt1 = false
			show_prompt2 = true
			tower_lit.emit()
		elif lit == true:
			print("This is already lit!")

	# Handle RETRIEVE LIGHT for this object \\\\ ---> Fix for duplicates? # Fixed! -Mo
	elif global.player_has_light == false and Input.is_action_just_pressed("lantern_take") and is_in_area == true:
		if lit == true:
			print("Unlit mechanism!")
			global.player_has_light = true
			global.tower_has_light = false
			lit = false
			$MechanismLight.hide()
			$Prompt.show()
			$Prompt2.hide()
			show_prompt1 = true
			show_prompt2 = false
			tower_lit.emit() #this should undo whatever lighting the tower does

func _on_trigger_area_body_entered(_body: CharacterBody3D) -> void:
	is_in_area = true
	global.is_player_in_area = true

func _on_trigger_area_body_exited(_body: CharacterBody3D) -> void:
	show_prompt1 = false
	show_prompt2 = false
	is_in_area = false
	global.is_player_in_area = false
