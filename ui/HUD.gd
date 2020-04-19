extends CanvasLayer

var wood : int = 0
var rock : int = 0

func _on_Button_pressed():
	show_info("You need 10 wood and 10 rocks")

func show_info(text):
	$Inventory/VBoxContainer/Button.disabled = true
	$Inventory/VBoxContainer/MessageLabel.show()
	$Inventory/VBoxContainer/MessageLabel.text = text
	yield(get_tree().create_timer(5), "timeout")
	$Inventory/VBoxContainer/MessageLabel.hide()
	$Inventory/VBoxContainer/Button.disabled = false

func update_wood():
	wood += 1
	$Inventory/VBoxContainer/WoodLabel.text = "Wood : %d/10" % wood

func update_rock():
	rock += 1
	$Inventory/VBoxContainer/RocksLabel.text = "Rock : %d/10" % rock
