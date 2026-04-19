extends Node2D

@onready var ladle_and_liquid: Node2D = $LadleAndLiquid
@onready var liquid_sprite: Sprite2D = $LadleAndLiquid/LiquidSprite

var impact: float = 0.4
var velocity: float
var min_velocity: float = 0.01
var max_velocity: float = 10
var min_rotation: float = 0.0
var max_rotation: float = 0.5
var drag: float = 0.01

var picked_color: Color

var colors = [
	Color(0.755, 0.606, 0.345, 1.0),
	Color(0.929, 0.47, 0.507, 1.0),
	Color(0.408, 0.697, 0.617, 1.0),
	Color(0.509, 0.633, 0.855, 1.0),
	Color(0.186, 0.567, 0.7, 1.0),
	Color(0.386, 0.47, 0.811, 1.0),
	Color(0.592, 0.674, 0.335, 1.0),
	Color(0.805, 0.579, 0.339, 1.0)
]

var fuel_is_empty: bool = false

var accelerating: bool = false
var rotate_amt: float
var laps: int = 0:
	set(new_value):
		laps = new_value
		SignalBus.laps_updated.emit(new_value)

func _ready() -> void:
	SignalBus.rocket_fuel_empty.connect(stop_rotation)
	SignalBus.rocket_started.connect(set_minimum_rotation)
	picked_color = colors.pick_random()
	GameData.current[GameData.KEY_COLOR_PICKED] = picked_color
	liquid_sprite.modulate = picked_color

func _process(delta: float) -> void:
	match accelerating:
		true: 
			velocity = clampf(velocity + (impact * delta), min_velocity, max_velocity)
			rotate_amt += velocity * delta
		false:
			velocity = clampf(velocity - (impact * delta), min_velocity, max_velocity)
			rotate_amt -= velocity * (impact * delta)
	rotate_amt = clampf(rotate_amt, min_rotation, max_rotation)
	ladle_and_liquid.rotate(rotate_amt)
	laps = int(ladle_and_liquid.rotation_degrees/360)
	if fuel_is_empty == true and rotate_amt == 0:
		SignalBus.finished_rotating.emit()
		set_process(false)

func _on_ladle_collision_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("RocketFire"):
		accelerating = true

func _on_ladle_collision_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("RocketFire"):
		accelerating = false

func stop_rotation() -> void:
	drag = 100
	impact = 5
	min_rotation = 0
	fuel_is_empty = true

func set_minimum_rotation() -> void:
	min_rotation = 0.01
