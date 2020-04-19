extends Node2D

func toggle_fire():
	$FireParticules.emitting = !$FireParticules.emitting
	$SmokeParticles.emitting = !$SmokeParticles.emitting
	$Light2D.visible = !$Light2D.visible
