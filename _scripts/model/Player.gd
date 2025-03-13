# Player.gd
extends Node2D

@export var health: int = 20

var health_label : Label
var equipped_card: Card = null

@onready var equipped_card_image: TextureRect = $EquippedCard

func _ready():
	health_label = $HealthLabel
	update_health_display()

func take_damage(amount: int):
	if amount <= 0:
		print("No se puede curar con un valor negativo o cero.")
		return

	health -= amount
	if health < 0:
		health = 0
	print("El jugador ha recibido " + str(amount) + " de daño. Vida restante: " + str(health))
	update_health_display()

func heal(amount: int):
	health += amount
	if health > 20:
		health = 20
	print("El jugador ha sido curado en " + str(amount) + ". Vida actual: " + str(health))
	update_health_display()

func update_health_display():
	health_label.text = "Vida: " + str(health)

func is_dead() -> bool:
	return health == 0

func equip_card(card: Card):
	if equipped_card:
		print("Reemplazando equipo:", equipped_card.name, "->", card.name)
	else:
		print("Equipando:", card.name)
	equipped_card = card
	update_equipped_card_display()
	print("Carta equipada:", equipped_card.name)

func update_equipped_card_display():
	if equipped_card:
		equipped_card_image.texture = equipped_card.image
	else:
		equipped_card_image.texture = null

func get_equipped_card():
	return equipped_card
