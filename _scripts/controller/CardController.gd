# CardController.gd
extends Node
class_name Cardcontroller

signal card_selected(selected_card)

var is_selected: bool = false
@export var card: Card

func select_card():
    is_selected = !is_selected
    emit_signal("card_selected", self)

func apply_card_effect():
    if card:
        card.apply_effect()