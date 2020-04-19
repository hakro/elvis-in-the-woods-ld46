extends Area2D

const NAME = "axe"

func collect():
	$Axe/AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		monitorable = false
		monitoring = false
		$Axe.queue_free()
