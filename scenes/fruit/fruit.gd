extends Node2D

@onready var sprite_full: Sprite2D = $SpriteFull
@onready var sprite_chopped: Sprite2D = $SpriteChopped
@onready var sprite_powder: Sprite2D = $SpritePowder
@onready var collision_checks: Node2D = $CollisionChecks
@onready var fruit_collision_full: Area2D = $CollisionChecks/FruitCollisionFull
@onready var fruit_collision_chopped: Area2D = $CollisionChecks/FruitCollisionChopped

enum Statuses {FULL, CHOPPED, GROUNDED}

var status = Statuses.FULL

func _on_fruit_collision_full_area_entered(area: Area2D) -> void:
	if area.is_in_group("LaserBeam") and status == Statuses.FULL:
		sprite_full.hide()
		sprite_chopped.show()

func _on_fruit_collision_chopped_area_entered(area: Area2D) -> void:
	if area.is_in_group("LaserBeam") and status == Statuses.CHOPPED:
		sprite_chopped.hide()
		sprite_powder.show()

func _on_fruit_collision_full_area_exited(area: Area2D) -> void:
	if area.is_in_group("LaserBeam") and status == Statuses.FULL:
		fruit_collision_full.hide()
		fruit_collision_chopped.show()
		status = Statuses.CHOPPED
