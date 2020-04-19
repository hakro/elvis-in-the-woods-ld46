extends Node2D

func toggle_fire():
	$FireParticules.emitting = !$FireParticules.emitting
	$SmokeParticles.emitting = !$SmokeParticles.emitting

func _input(event : InputEvent):
	if event.is_action_pressed("ui_accept"):
		toggle_fire()
