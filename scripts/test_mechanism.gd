extends Node3D
var show_prompt = false

# HIDE LIGHT AT START
func _ready() -> void:
	$MechanismLight.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# Handle Text Pop-Up for Lantern Interaction
	if show_prompt == false and global.is_player_in_area == true:
		$Prompt.show()
	else:
		$Prompt.hide()

	# Handle GIVE LIGHT for this object \\\\ ---> Fix for duplicates?
	if Input.is_action_just_pressed("lantern_give") and global.is_player_in_area == true:
		global.player_has_light = false
		$MechanismLight.show()
		$Prompt.hide()
		show_prompt = false

	# Handle RETRIEVE LIGHT for this object \\\\ ---> Fix for duplicates?
	elif Input.is_action_just_pressed("lantern_take") and global.is_player_in_area == true:
		global.player_has_light = true
		$MechanismLight.hide()

func _on_trigger_area_body_entered(_body: CharacterBody3D) -> void:
	global.is_player_in_area = true

func _on_trigger_area_body_exited(_body: CharacterBody3D) -> void:
	$Prompt.hide()
	global.is_player_in_area = false
