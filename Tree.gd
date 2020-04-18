extends StaticBody2D

var health := 5

func take_damage():
	health -= 1
	if health == 0:
		$Tree.hide()
		$TreeTrunk.show()
		$HurtBox.queue_free()
