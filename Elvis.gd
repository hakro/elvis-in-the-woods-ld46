extends KinematicBody2D

const SPEED := 90

var is_moving = false
var is_attacking = false
var can_attack = true

# This is a basic inventory : 
var woods := 0
const MAX_WOODS := 5

var rocks := 0
const MAX_ROCKS := 5

var axe := 0
const MAX_AXES := 1

func _process(delta):
	var direction := Vector2()
	is_moving = false
	
	attack()
	move_and_slide(get_move_direction() * SPEED)

func attack():
	if Input.is_action_just_pressed("ui_accept") and !is_attacking:
		is_moving = false
		is_attacking = true
		$AnimatedSprite.play("attack")
		for obj in $HitBox.get_overlapping_areas():
			if obj.get_parent().is_in_group("damageables"):
				obj.get_parent().take_damage()
		
		yield(get_tree().create_timer(0.22), "timeout")
		is_attacking = false

func get_move_direction():
	var direction := Vector2()
	if is_attacking == false:
		if Input.is_action_pressed("ui_left"):
			direction += Vector2.LEFT
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = true
			is_moving = true
		if Input.is_action_pressed("ui_right"):
			direction += Vector2.RIGHT
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = false
			is_moving = true
		if Input.is_action_pressed("ui_up"):
			direction += Vector2.UP
			$AnimatedSprite.play("run")
			is_moving = true
		if Input.is_action_pressed("ui_down"):
			direction += Vector2.DOWN
			$AnimatedSprite.play("run")
			is_moving = true
		if is_moving == false:
			$AnimatedSprite.play("idle")

	return direction.normalized()

# Gather collectibles
func _on_HitBox_area_entered(area : Area2D):
	if area.is_in_group("collectibles"):
		match area.NAME:
			"rock":
				if 	rocks < MAX_ROCKS:
					area.collect()
					rocks += 1
					print("Rock collected")
			"wood":
				if 	woods < MAX_WOODS:
					area.collect()
					woods += 1
					print("Wood collected")

