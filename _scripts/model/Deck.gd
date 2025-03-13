# Deck.gd
extends Node2D
class_name Deck

signal deck_updated(drawn_cards)

var deck: Array = []
var deck_back_image = preload("res://assets/back.png")

func _ready():
	init_deck()

func init_deck():
	var suits = ["spades", "hearts", "clubs", "diamonds"]
	for suit_index in range(4):
		for card_number in range(1, 14):
			var card = Card.new()
			card.name = "%d of %s" % [card_number, suits[suit_index]]
			card.value = card_number
			card.suit = suits[suit_index]
			card.image = load("res://assets/%d_%s.png" % [card_number, card.suit])

			if ((card.suit == "hearts" || card.suit == "diamonds") && (card.value == 1 || card.value > 10)):
				continue

			deck.append(card)
	deck.shuffle()

func draw_cards(amount) -> Array:
	var drawn_cards = []
	for i in range(min(amount, deck.size())):
		var card = deck.pop_back()
		drawn_cards.append(card)
		print("[Deck] Carta tomada:", card.name)

	print("Cartas faltantes:", deck.size())

	emit_signal("deck_updated", drawn_cards)

	return drawn_cards

func add_cards(cards: Array):
	for card in cards:
		deck.insert(0, card)
	emit_signal("deck_updated", [])