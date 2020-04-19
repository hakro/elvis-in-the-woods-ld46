extends StaticBody2D

var health := 5
var nb_planks := 3
var is_dead := false
var wood_plank : PackedScene = preload("res://WoodPlank.tscn")

func take_damage():
	health -= 1
	$AnimationPlayer.play("damage")
	if health == 0 and !is_dead:
		$Tree.hide()
		$TreeTrunk.show()
		$HurtBox.queue_free()
		for i in range(nb_planks):
			var plank = wood_plank.instance()
			add_child(plank)
		is_dead = true
