# DeckController.gd
extends Node
class_name DeckController

@export var deck: Deck
signal cards_drawn(cards)

func _ready():
	if not deck:
		print("[DeckController] Deck is null")
		deck = Deck.new()
		deck.init_deck()
	if deck:
		deck.deck_updated.connect(_on_deck_updated)

func draw_cards(amount):
	var drawn_cards = null
	print("[DeckController] Dibujando Cartas: ", amount)
	if deck:
		drawn_cards = deck.draw_cards(amount)
		emit_signal("cards_drawn", drawn_cards)
	else: 
		print("[DeckController] Deck is null")
	print("[DeckController] DrawnCards: ", drawn_cards)
	return drawn_cards

func _on_deck_updated(drawn_cards):
	print("[DeckController] Cartas robadas:", drawn_cards
        .map(func(c): return c.name))