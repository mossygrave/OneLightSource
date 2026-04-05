extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var slow_down_anim = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame.
func _process(_delta: float) -> void:
	
	# Slow down/Stop lantern animation when NO light
	if global.player_has_light == false:
		if slow_down_anim == false:
			slow_down_anim = true
			animation_player.speed_scale = 0.5
			$Timer.start()
	# Resume Animation when YES light
	else:
		animation_player.speed_scale = 1.5
		$AnimationPlayer.play()

# Actually Stop the Lantern
func _on_timer_timeout() -> void:
	if $Timer.is_stopped():
		$AnimationPlayer.pause()
		slow_down_anim = false
