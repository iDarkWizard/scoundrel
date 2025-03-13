# Main.gd
extends Node

func _ready():
	print("[Main] Iniciando juego")
	
	# Cambiar a la escena de la mesa, asegurándonos de que la escena se instancie correctamente
	var table_scene = load("res://scenes/Table.tscn").instantiate()  # Instanciamos la mesa
	get_tree().root.add_child.call_deferred(table_scene)  # Añadimos la mesa al árbol de nodos raíz (sin cambiar la escena actual)
	
	# Instanciar al jugador
	var player_scene = load("res://scenes/Player.tscn").instantiate()  # Instanciamos al jugador
	table_scene.add_child(player_scene)  # Añadimos al jugador a la escena de la mesa
	
	print("[Main] Juego iniciado con el jugador en la mesa")
