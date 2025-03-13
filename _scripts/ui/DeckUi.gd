# DeckUi.gd
extends CardDisplay
class_name DeckUi

@export var deck_controller: DeckController

func _ready():
	show_back = true
	update_card_display()
	
	if deck_controller:
		deck_controller.cards_drawn.connect(_on_cards_drawn)

func _on_cards_drawn(drawn_cards):
	print("[DeckUi] Se han robado cartas:", drawn_cards.map(func(c): return c.name))
	if deck_controller.deck.deck.size() == 0:
		hide()
