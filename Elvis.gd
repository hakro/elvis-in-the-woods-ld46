extends KinematicBody2D

const SPEED := 90

var is_moving = false
var is_attacking = false
var can_attack = true

func _process(delta):
	var direction := Vector2()
	is_moving = false
	
	attack()

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

	direction = direction.normalized()
	move_and_slide(direction * SPEED)

func attack():
	if Input.is_action_just_pressed("ui_accept") and !is_attacking:
		is_moving = false
		is_attacking = true
		$AnimatedSprite.play("attack")
		for obj in $HitBox.get_overlapping_areas():
			if obj.get_parent().is_in_group("damageable"):
				obj.get_parent().take_damage()
		
		yield(get_tree().create_timer(0.12), "timeout")
		is_attacking = false
