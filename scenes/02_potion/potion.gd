extends PanelContainer

@onready var potion_bottle: TextureRect = $MarginContainer/PotionBottle
@onready var potion_liquid: TextureRect = $MarginContainer/PotionLiquid


func _ready() -> void:
	print(GameData.current[GameData.KEY_COLOR_PICKED])
	potion_liquid.modulate = GameData.current[GameData.KEY_COLOR_PICKED]
