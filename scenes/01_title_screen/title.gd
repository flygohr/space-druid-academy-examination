extends Node2D

const INITIAL_SCENE: StringName = ScenesConstants.SCENE_PATHS[ScenesConstants.KEY_ASSIGNMENT_SCREEN]

@onready var play_button: Button = $CanvasLayer/MarginContainer/VBoxContainer/PlayButton
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GameData.current[GameData.KEY_IS_NEW_GAME] = true #TODO: delete on release
	animation_player.play("title_bounce")
	sprite_2d.offset.x = (get_viewport_rect().size.x/2)
	get_tree().root.size_changed.connect(on_viewport_size_changed)
	if (GameData.current[GameData.KEY_IS_NEW_GAME]) == true:
		play_button.text = "NEW GAME"
	else: play_button.text = "CONTINUE"

func _on_play_button_pressed() -> void:
	ScenesManager.load_scene(INITIAL_SCENE)

func _on_options_button_pressed() -> void:
	SignalBus.pause_game.emit()

#https://forum.godotengine.org/t/how-do-i-detect-when-the-window-is-resized/121381
func on_viewport_size_changed():
	sprite_2d.offset.x = (get_viewport_rect().size.x/2)
