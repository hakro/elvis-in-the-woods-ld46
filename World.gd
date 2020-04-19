extends Node2D

func _ready():
	$Elvis.connect("collect_wood", self, "_on_wood_collected")
	$Elvis.connect("collect_rock", self, "_on_rock_collected")
	$Elvis.connect("collect_axe", self, "_on_axe_collected")

func _on_wood_collected():
	$HUD.update_wood()

func _on_rock_collected():
	$HUD.update_rock()

func _on_axe_collected():
	$HUD.layer = 1
