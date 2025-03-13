# CardDisplay.gd
extends Control
class_name CardDisplay

const DECK_TEXTURE_PATH = "res://assets/back.png"
const DEFAULT_SIZE = Vector2(100, 150)

@export var card: Card
@export var is_selected: bool = false
@export var show_back: bool = false

@export var back_texture: Texture = preload(DECK_TEXTURE_PATH)

@onready var texture_rect: TextureRect = $TextureRect

func _ready():
    size = DEFAULT_SIZE
    texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
    update_card_display()

func update_card_display():
    if show_back:
        texture_rect.texture = back_texture
    elif card:
        texture_rect.texture = card.get_texture()

func select_card():
    is_selected = !is_selected
    modulate = Color(1, 1, 0) if is_selected else Color(1, 1, 1)

func deselect_card():
    is_selected = false
    modulate = Color(1, 1, 1)
