extends Label

export var display_length := 5

func _ready():
	yield(get_tree().create_timer(display_length), "timeout")
	$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		queue_free()
