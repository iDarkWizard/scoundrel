# DeckUi.gd
extends CardDisplay
class_name DeckUi

@export var deck_controller: DeckController

func _ready():
	show_back = true
	update_card_display()

	deck_controller = get_node("/root/Table/Controllers/DeckController")

	if not deck_controller:
		print("[DeckUi] DeckController is null")

	if deck_controller:
		deck_controller.cards_drawn.connect(_on_cards_drawn)

func _on_cards_drawn(drawn_cards):
	print("[DeckUi] Se han robado cartas: ", drawn_cards.map(func(c): return c.name))
	if deck_controller.deck.deck.size() == 0:
		hide()

func draw_cards(amount):
	var drawn_cards = null
	print("[DeckUi] Dibujando cartas: ", amount)
	if deck_controller:
		drawn_cards = deck_controller.draw_cards(amount)
	else:
		print("[DeckUi] DeckController is null");
	print("[DeckUi] Drawn Cards: ", drawn_cards)
	return drawn_cards
