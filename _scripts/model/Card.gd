# card.gd
extends Resource

class_name Card

@export var name: String = "Carta de ejemplo"
@export var value: int = 1
@export var type: String = "Ataque"
@export var suit: String = "Hearts"
@export var image: Texture = preload("res://assets/back.png")  # Asignar imagen por defecto

var effect: String = ""

func apply_effect():
	match type:
		"Ataque":
			print(name + " ha atacado con un valor de " + str(value))
		"Defensa":
			print(name + " ha defendido con un valor de " + str(value))
		_:
			print(name + " no tiene efectos especiales.")

func get_texture() -> Texture:
	return image
