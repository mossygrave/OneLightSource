extends CharacterBody3D

# Movement Variables/Constants
@onready var speed := 3.0
const CROUCH_MOVE_SPEED := 1.5
const WALKING_SPEED := 3.0
const SPRINT_SPEED := 6.0
const JUMP_VELOCITY := 4
var sprinting = false

# Crouch Variables/Constants
const STANDING_HEIGHT := 0.0
const CROUCHING_HEIGHT := -0.5
var crouching = false

# Mouse Variables
var sensitivity := 0.1

# Other
@onready var camera = $Head/Camera3D


# ------------------ Ready Function ------------------
func _ready():
	pass

# --------------------- Physics Process ---------------------
func _physics_process(delta: float) -> void:
	# Use Crouch/Sprint
	#crouch()
	sprint()
	lantern_on_off()

	# Jump (Choosing to keep it out)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Movement
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		$WalkingSound.play()
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()

# ------------------ Looking/Mouse ------------------
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		$Head.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		$Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-80), deg_to_rad(80))
		rotation.y = $CameraCollision.global_rotation.y

# ------------------ Sprint ------------------
func sprint():
	if Input.is_action_just_pressed("sprint") and is_on_floor():
		$WalkingSound.stop()
		$SprintingSound.play()
		speed = SPRINT_SPEED
		camera.v_offset = STANDING_HEIGHT
		sprinting = true
	if Input.is_action_just_released("sprint") and is_on_floor():
		$SprintingSound.stop()
		$WalkingSound.play()
		speed = WALKING_SPEED
		sprinting = false

# ------------------ Crouch ------------------ (Currently not in use, skip)
#func crouch():
	#if Input.is_action_just_pressed("crouch(hold)"):
		#$WalkingSound.stop()
		#$SprintingSound.stop()
		#speed = CROUCH_MOVE_SPEED
		#camera.v_offset = CROUCHING_HEIGHT
		#crouching = true
		#sprinting = false
		##$MeshInstance3D make smaller body
		##y$CollisionShape3D make smaller collision
	#if Input.is_action_just_released("crouch(hold)"):
		#camera.v_offset = STANDING_HEIGHT
		#if sprinting == true:
			#$SprintingSound.play()
			#speed = SPRINT_SPEED
			#crouching = false
			#sprinting = true
		#else:
			#$WalkingSound.play()
			#speed = WALKING_SPEED
			#crouching = false
	#
		##$MeshInstance3D restore to normal body
		##$CollisionShape3D restore to normal collision
	#if Input.is_action_just_pressed("crouch(toggle)"):
		#if crouching == false:
			#$WalkingSound.stop()
			#$SprintingSound.stop()
			#speed = CROUCH_MOVE_SPEED
			#$Head/Camera3D.v_offset = CROUCHING_HEIGHT
			#crouching = true
		#else:
			#camera.v_offset = STANDING_HEIGHT
			#if sprinting == true:
				#$SprintingSound.play()
				#speed = SPRINT_SPEED
				#crouching = false
				#sprinting = true
			#else:
				#$WalkingSound.play()
				#speed = WALKING_SPEED
				#crouching = false

# ---------------- Handle Lantern ----------------
func lantern_on_off():
	# If no light, lantern light off
	if global.player_has_light == false:
		#print("Lantern Off") <--- Debugging Tool
		$Head/SubViewportContainer/SubViewport/Lantern/OffLight.show()
		$Head/LanternLight.hide()
		$Head/SubViewportContainer/SubViewport/Lantern/LightBall.hide()
	# If yes light, lantern light on
	elif global.player_has_light == true:
		#print("Lantern On") <--- Debugging Tool
		$Head/SubViewportContainer/SubViewport/Lantern/OffLight.hide()
		$Head/LanternLight.show()
		$Head/SubViewportContainer/SubViewport/Lantern/LightBall.show()
