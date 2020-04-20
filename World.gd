extends Node2D

func _ready():
	$Elvis.connect("collect_wood", self, "_on_wood_collected")
	$Elvis.connect("collect_rock", self, "_on_rock_collected")
	$Elvis.connect("collect_axe", self, "_on_axe_collected")
	$HUD.connect("make_fire_button_clicked", self, "_on_make_fire_button_clicked")
	yield(get_tree().create_timer(6), "timeout")
	$MessageArea.layer = 1

func _on_wood_collected():
	$HUD.update_wood()

func _on_rock_collected():
	$HUD.update_rock()

func _on_axe_collected():
	$HUD.layer = 1
	$MessageArea/Panel/Label.text = "Nice ! Now, I need to gather some wood and rocks. Fortunatly I have a few matches. But I have to be quick. It's getting dark."
	$DayNight.show()
	$AnimationPlayer.play("night")

func _on_make_fire_button_clicked():
	$Elvis.make_fire()
	$MessageArea/Panel/Label.text = "Cool ! But I have to keep the fire alive by bringing more wood. I shouldn't stay away for long though, or I'll freeze."
