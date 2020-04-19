extends Area2D

const NAME = "axe"

var info_label : PackedScene = preload("res://ui/InfoLabel.tscn")

func collect():
	show_info_label()
	$Axe/AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		monitorable = false
		monitoring = false
		$Axe.queue_free()

func show_info_label():
	var label : Label = info_label.instance() 
	label.text = "SpaceBar to\n use Axe"
	label.rect_position.x -= 35
	label.rect_position.y -= 40
	add_child(label)
