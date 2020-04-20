extends KinematicBody2D

const SPEED := 90

var is_moving = false
var is_attacking = false
var can_attack = true
var fire_scene : PackedScene = preload("res://Fire.tscn")
var fire_instance

# This is a basic inventory : 
var woods := 0
const MAX_WOODS := 10
signal collect_wood

var rocks := 0
const MAX_ROCKS := 10
signal collect_rock

var axe := 0
const MAX_AXES := 1
signal collect_axe

func _process(_delta):
	#var direction := Vector2()
	is_moving = false
	
	attack()
	move_and_slide(get_move_direction() * SPEED)

func attack():
	if Input.is_action_just_pressed("ui_accept") and !is_attacking and axe > 0:
		is_moving = false
		is_attacking = true
		$AnimatedSprite.play("attack")
		for obj in $HitBox.get_overlapping_areas():
			if obj.get_parent().is_in_group("damageables"):
				obj.get_parent().take_damage()
		
		yield(get_tree().create_timer(0.2), "timeout")
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
				if 	rocks < MAX_ROCKS and axe > 0:
					area.collect()
					rocks += 1
					emit_signal("collect_rock")
			"wood":
				if 	woods < MAX_WOODS and axe > 0:
					area.collect()
					woods += 1
					emit_signal("collect_wood")
			"axe":
				if 	axe < MAX_AXES:
					area.collect()
					axe = 1
					emit_signal("collect_axe")

func make_fire():
	if rocks >= 10 and woods >= 10:
		var fire = fire_scene.instance()
		get_parent().add_child(fire)
		fire.position.y = position.y
		if $AnimatedSprite.flip_h:
			fire.position.x = position.x - 15
		else:
			fire.position.x = position.x + 15
		woods = 0
		rocks = 0
		# Crap so I can finish fast, need to use signal instead
		get_parent().get_node("HUD").init_wood()

func _input(event : InputEvent):
	if event.is_action_pressed("light_match"):
		for obj in $HitBox.get_overlapping_areas():
			# Close to fire
			if obj.get_parent().is_in_group("fire"):
				fire_instance = obj.get_parent()
				if !fire_instance.get_node("FireParticules").emitting:
					fire_instance.toggle_fire()
				else:
					# Use wood to keep fire alive
					woods = 0
					get_parent().get_node("HUD").init_wood()
					#fire_instance.add_wood()
