extends Node2D

@onready var deck = $UI/DeckUI
@onready var hand = $UI/HandUI
@onready var action_button: Button = $Buttons/ActionButton
@onready var run_button: Button = $Buttons/RunButton
@onready var draw_button: Button = $Buttons/DrawButton

var runs_left = 0
var player : Node

func _ready():
	print("[Table] Abriendo mesa")
	player = get_node("Player")
	print("[Table] Vida del jugador: " + str(player.health))

	if not deck:
		print("[Table] deck is null")
	else:
		print("[Table] Deck: ", deck)
	
	if hand:
		hand.connect("hand_card_selected", Callable(self, "_on_hand_card_selected"))	
	else:
		print("[Table] hand is null")

	deal_cards_to_hand(4)
	action_button.disabled = true
	action_button.text = "Selecciona una carta"
	action_button.connect("pressed", Callable(self, "_on_action_button_pressed"))
	
	run_button.disabled = false
	run_button.text = "Huir"
	run_button.connect("pressed", Callable(self, "_on_run_button_pressed"))

	draw_button.disabled = not hand.can_redraw()
	draw_button.text = "Repartir"
	draw_button.connect("pressed", Callable(self, "_on_draw_button_pressed"))
	update_draw_button()
	update_run_button()


func deal_cards_to_hand(amount):
	print("[Table] Repartiendo cartas")
	var cards = deck.draw_cards(amount)
	runs_left -= 1
	print("[Table] Sending cards: ", cards)
	hand.receive_cards(cards)

func _on_hand_card_selected(selected_card: CardUi):
	print("[TableUi] hand_card_Selected: ", selected_card)
	action_button.disabled = false
	match selected_card.card.suit:
		"hearts":
			action_button.text = "Curar"
		"diamonds":
			action_button.text = "Equipar"
		_:
			action_button.text = "Combatir"

func _on_action_button_pressed():
	if hand.selected_card:
		match hand.selected_card.card.suit:
			"hearts":
				heal(hand.selected_card.card)
			"diamonds":
				equip(hand.selected_card.card)
			_:
				combat(hand.selected_card.card)

func _on_draw_button_pressed():
	deal_cards_to_hand(hand.get_needed_cards())
	draw_button.disabled = not hand.can_redraw()

func _on_run_button_pressed():
	runs_left = 2
	return_cards_to_deck()
	deal_cards_to_hand(4)
	update_run_button()

func return_cards_to_deck():
	var cards_in_hand = hand.get_cards()
	deck.add_cards(cards_in_hand)

func update_run_button():
	if runs_left <= 0:
		run_button.disabled = false
	else:
		run_button.disabled = true

func get_cards() -> Array:
	return hand.get_cards()

func update_draw_button():
	draw_button.disabled = not hand.can_redraw()

func remove_card_from_hand(card: CardUi):
	hand.remove_card(card)
	update_draw_button()

func heal(card: Card):
	print("Equipar objeto")
	player.heal(card.value)
	remove_card_from_hand(hand.selected_card)

func equip(card: Card):
	print("Equipar objeto")
	player.equip_card(card)
	remove_card_from_hand(hand.selected_card)

func combat(card: Card):
	print("Combatir: ", card.name)
	var equipped_card = player.get_equipped_card()
	var damage = card.value
	if equipped_card && equipped_card.value >= card.value:
		damage = damage - equipped_card.value
	player.take_damage(damage)
	remove_card_from_hand(hand.selected_card)
