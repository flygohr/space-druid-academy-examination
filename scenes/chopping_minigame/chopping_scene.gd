extends Node2D

# when ready, start the minigame
# start top slider
# when top slider is set, get its position and start second slider
# when both coords are set, draw cut line
# then calculate score to later add to globals

@onready var top_slider: Node2D = $TopSlider
@onready var bottom_slider: Node2D = $BottomSlider
@onready var laser: Node2D = $Laser
@onready var cutting_board: Node2D = $"Cutting board"

var top_coords: Vector2
var bottom_coords: Vector2

var minigame_started: bool = false
var rounds: int = 3

func _ready() -> void:
	top_slider.slider_stopped.connect(start_second_slider)
	bottom_slider.slider_stopped.connect(draw_laser)
	SignalBus.laser_finished_firing.connect(restart_laser)
	cutting_board.spawn_fruit()

func _input(event):
	if event.is_action_pressed("Interact") and !minigame_started and rounds > 0:
		top_slider.start_slider()
		minigame_started = true
		rounds -= 1

func start_second_slider(coords: Vector2) -> void:
	top_coords = coords
	bottom_slider.start_slider()

func draw_laser(coords: Vector2) -> void:
	bottom_coords = coords
	# https://kidscancode.org/godot_recipes/4.x/2d/line_collision/index.html
	laser.set_coords(top_coords, bottom_coords)
	laser.start_laser()
	
func restart_laser() -> void:
	minigame_started = false
