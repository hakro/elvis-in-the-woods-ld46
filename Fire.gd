extends Node2D

var info_label : PackedScene = preload("res://ui/InfoLabel.tscn")
var health = 10
var fire_start_time = 0

func toggle_fire():
	$FireParticules.emitting = !$FireParticules.emitting
	$SmokeParticles.emitting = !$SmokeParticles.emitting
	$Light2D.visible = !$Light2D.visible
	$LifeLabel.show()
	$LifeLabel.text = "Life : 10"
	$WoodLabel.show()
	$HealthTimer.start()

func show_info_label():
	var label : Label = info_label.instance() 
	label.text = "Press N to light\nthe fire with a match"
	label.rect_position.x -= 45
	label.rect_position.y -= 40
	add_child(label)


func _on_FireProximity_body_entered(body):
	if !$FireParticules.emitting:
		show_info_label()

func _on_HealthTimer_timeout():
	if health > 0:
		health -= 1
		$LifeLabel.text = "Life : %d" % health
	else:
		get_parent().get_node("GameOver").layer = 100
		get_parent().get_node("GameOver/Panel").show()

func add_health(additional_health : int):
	health += additional_health
	$LifeLabel.text = "Life : %d" % health
