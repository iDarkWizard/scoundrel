# DeckController.gd
extends Node
class_name DeckController

@export var deck: Deck
signal cards_drawn(cards)

func _ready():
	if deck:
		deck.deck_updated.connect(_on_deck_updated)

func draw_cards(amount):
	if deck:
		var drawn_cards = deck.draw_cards(amount)
		emit_signal("cards_drawn", drawn_cards)

func _on_deck_updated(drawn_cards):
	print("[DeckController] Cartas robadas:", drawn_cards
        .map(func(c): return c.name))