extends Node2D

@onready var assignment_label: Label = $CanvasLayer/MarginContainer/VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/AssignmentLabel

func _ready() -> void:
	if GameData.current[GameData.KEY_IS_NEW_GAME] == true:
		play_tutorial()
		
	assignment_label.text = str(
		"Assignment #",
		GameData.current[GameData.KEY_CURRENT_LEVEL],
		" ingredients:"
	).to_upper()

func play_tutorial() -> void:
	# generate protocol number to be referenced later
	var random_number: int = randi()
	var protocol_letters: Array = "abcdefghijklmnopqrstuvwxyz".split()
	var protocol_number: String = str(
		protocol_letters.pick_random().to_upper(),
		protocol_letters.pick_random().to_upper(),
		"-",
		random_number
	)
	
	PopupManager.show_popup_dialog(str(
		"Dear Space Druid, your Operating Licence ",
		protocol_number,
		" is expiring soon."
		))
	await PopupManager.next_button_pressed
	GameData.current[GameData.KEY_PROTOCOL_NUMBER] = protocol_number
	
	PopupManager.show_popup_dialog("To renew your Operating Licence, you will need to complete Assignments for the Galactic Druid Guild (GDG).")
	await PopupManager.next_button_pressed
	
	PopupManager.show_popup_dialog("Each Assignment will consist of the making of 1 (ONE) batch of Space Potions, using a given list of Space Fruit.")
	await PopupManager.next_button_pressed
	
	var total_assignments: int = GameData.LEVELS.size()
	
	PopupManager.show_popup_dialog(str("You will be graded on the result of each Assignment. Complete the required ", total_assignments, " Assignments to renew you Licence."))
	await PopupManager.next_button_pressed
	
	PopupManager.show_popup_dialog("Please proceed to your first Assignment and familiarize with the ingredients list.", "Start")
	await PopupManager.next_button_pressed

func _on_start_button_pressed() -> void:
	ScenesManager.load_scene(ScenesConstants.SCENE_PATHS[ScenesConstants.KEY_GRABBING_MINIGAME])
