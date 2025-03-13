extends Node2D

signal hand_card_selected(card)

@onready var card_container = $HBoxContainer
var table: Node
var selected_card : CardUi = null


func _ready():
	for child in card_container.get_children():
		child.queue_free()
	card_container.add_theme_constant_override("separation", 110)
	table = get_parent()
	if table:
		print("🔗 Conectando HandUi con TableUi")
		connect("hand_card_selected", Callable(table, "_on_hand_card_selected"))
	else:
		print("⚠️ No se encontró TableUi como padre")

func receive_cards(cards):
	for card in cards:
		var card_scene = preload("res://scenes/Card.tscn")
		var card_ui = card_scene.instantiate()
		var texture_rect = card_ui.get_node("CardImage") as TextureRect
		if texture_rect:
			texture_rect.texture = card.image
		card_ui.card = card
		card_ui.connect("card_selected", Callable(self, "_on_card_selected"))
		card_container.add_child(card_ui)
	print("[Hand] Hijos en HBoxContainer después de agregar cartas: ", card_container.get_child_count())

func _on_card_selected(selected_card: CardUi):
	if selected_card != self.selected_card:
		if self.selected_card:
			self.selected_card.deselect_card()
		self.selected_card = selected_card
		emit_signal("hand_card_selected", selected_card)

func can_redraw():
	return card_container.get_child_count() < 3

func get_needed_cards():
	return 4 - card_container.get_child_count()

func remove_card(card_ui: CardUi):
	print("remove card")
	card_ui.queue_free()
	if selected_card == card_ui:
		selected_card = null

func get_cards():
	var cards_to_return : Array = []

	for card_ui in card_container.get_children():
		var card = card_ui.card
		cards_to_return.append(card)
		card_ui.queue_free()
		print("Carta: ", card)
	return cards_to_return
