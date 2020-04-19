extends Node2D

var info_label : PackedScene = preload("res://ui/InfoLabel.tscn")

func toggle_fire():
	$FireParticules.emitting = !$FireParticules.emitting
	$SmokeParticles.emitting = !$SmokeParticles.emitting
	$Light2D.visible = !$Light2D.visible

func show_info_label():
	var label : Label = info_label.instance() 
	label.text = "Press N to\n light the fire"
	label.rect_position.x -= 35
	label.rect_position.y -= 40
	add_child(label)


func _on_FireProximity_body_entered(body):
	if !$FireParticules.emitting:
		show_info_label()
