extends Node2D

@onready var potion_name_label: RichTextLabel = $CanvasLayer/MarginContainer/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/PotionNameLabel
@onready var grade_label: RichTextLabel = $CanvasLayer/MarginContainer/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/GradeLabel

var names: Array = [
	"instability",
	"spacetime fracturing",
	"black hole removal",
	"ancient pulsar",
	"photonic split",
	"nebula expansion"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PopupManager.show_popup_dialog(str("Done! You managed to spin the ladle ",
	GameData.current[GameData.KEY_REVOLUTIONS_DONE],
	 " times."))
	potion_name_label.text = str(
		"potion of ",
		names.pick_random()
	).to_upper()
	
	grade_label.text = GameData.calculate_final_grade()
	
	await PopupManager.next_button_pressed
	PopupManager.show_popup_dialog(str("You have completed the Space Potion brewing process. Please proceed to the evaluation and grading."), "Proceed")
	await PopupManager.next_button_pressed

func _on_continue_button_pressed() -> void:
	ScenesManager.load_scene(ScenesConstants.SCENE_PATHS[ScenesConstants.KEY_REPORT_CARD])
