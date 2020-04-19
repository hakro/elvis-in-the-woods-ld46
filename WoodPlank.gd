extends Area2D

var random_x = rand_range(-1, 1)
var random_y = rand_range(-1, 1)
var random_distance = rand_range(25, 30)
var destination = Vector2(random_x, random_y).normalized() * random_distance
var is_collectible : bool = false

func _process(_delta):
	position = position.move_toward(destination, 2)
	if position.distance_to(destination) <= 2:
		is_collectible = true
		set_process(false)

func collect():
	if is_collectible:
		$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		queue_free()
