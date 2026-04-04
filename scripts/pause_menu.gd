extends CanvasLayer

var pause_moment = false

func _ready() -> void:
	visible = false
	get_tree().paused = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if get_tree().paused and pause_moment == true:
			visible = false
			get_tree().paused = false
			pause_moment = false
		else:
			visible = true
			get_tree().paused = true
			pause_moment = true
			

func _on_resume_button_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
