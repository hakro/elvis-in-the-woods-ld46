extends CanvasLayer

var wood : int = 0
var rock : int = 0

func _on_Button_pressed():
	show_info("You need 10 wood and 10 rocks")

func show_info(text):
	$Panel/VBoxContainer/Button.disabled = true
	$Panel/VBoxContainer/MessageLabel.show()
	$Panel/VBoxContainer/MessageLabel.text = text
	yield(get_tree().create_timer(5), "timeout")
	$Panel/VBoxContainer/MessageLabel.hide()
	$Panel/VBoxContainer/Button.disabled = false

func update_wood():
	wood += 1
	$Panel/VBoxContainer/WoodLabel.text = "Wood : %d/10" % wood

func update_rock():
	rock += 1
	$Panel/VBoxContainer/RocksLabel.text = "Rock : %d/10" % rock
