extends Area2D

var region_0 = [Vector2(0, 0), Vector2(3, 3)]
var region_1 = [Vector2(3, 0), Vector2(4, 3)]
var region_2 = [Vector2(7, 0), Vector2(4, 3)]
const NAME = "rock"

func _ready():
	#randomize()
	$Sprite.region_enabled = true
	var rand_region = randi() % 3
	if rand_region == 0:
		$Sprite.region_rect = Rect2(region_0[0].x, region_0[0].y, region_0[1].x, region_0[1].y)
	if rand_region == 1:
		$Sprite.region_rect = Rect2(region_1[0].x, region_1[0].y, region_1[1].x, region_1[1].y)
	if rand_region == 2:
		$Sprite.region_rect = Rect2(region_2[0].x, region_2[0].y, region_2[1].x, region_2[1].y)


func collect():
	$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		queue_free()
