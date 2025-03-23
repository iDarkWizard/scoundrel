extends Node
class_name HandController

@onready var hand_ui: HandUi

func _ready():
	hand_ui = get_node("HandUi") as HandUi
	if not hand_ui:
		print("⚠️ No se encontró HandUi")
	
	# Configuración inicial
	print("[HandController] Controlador de mano listo")

func _on_hand_card_selected(card: CardUi):
	# Lógica para manejar la carta seleccionada
	print("[HandController] Carta seleccionada: ", card.name)

func deal_cards_to_hand(amount):
	# Lógica para repartir cartas
	var cards = hand_ui.get_needed_cards()
	hand_ui.receive_cards(cards)

func remove_card_from_hand(card: CardUi):
	hand_ui.remove_card(card)

func get_hand_cards():
	# Lógica para obtener todas las cartas en la mano
	return hand_ui.get_cards()