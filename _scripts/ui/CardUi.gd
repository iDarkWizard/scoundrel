# cardUi.gd
extends CardDisplay
class_name CardUi

signal card_selected(selected_card)

func _ready():
	set_process_input(true)

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		select_card()
		emit_signal("card_selected", self)
