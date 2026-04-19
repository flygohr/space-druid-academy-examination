# Script to store the game data that will end into a savefile and are needed to run the game
# Kept separate from the SaveManager for compartimentalization

extends Node

const GAME_NAME: String = "Space Druid Licence Renewal"
const GAME_VERSION: String = "0.3"

# GAME CONFIG
const KEY_MUSIC_VOLUME: String = "music_volume"
const KEY_SFX_VOLUME: String = "sfx_volume"

var config: Dictionary = {
	KEY_MUSIC_VOLUME: 100,
	KEY_SFX_VOLUME: 100
}

# GAME DATA
# Variables to keep track of during gameplay
var active_save_slot: int = 1

var current_fruits: Array = []

# FRUIT DATA
const KEY_KIDNEY_GRAPES: String = "kidney grapes"
const KEY_ALL_SEEING_CHERRY: String = "all-seeing cherry"
const KEY_COSMIC_WATERMELON: String = "cosmic watermelon"

const FRUIT_KEYS: Array = [KEY_KIDNEY_GRAPES, KEY_ALL_SEEING_CHERRY, KEY_COSMIC_WATERMELON] # used for fruit generation?

enum FruitParams {MAIN_TEXTURE, CHOPPED_TEXTURE, POWDER_TEXTURE, SINGLE_TEXTURE, IS_ANIMATED, SPEED, PATH_COMPLEXITY}

const FRUIT_DATA: Dictionary = {
	KEY_KIDNEY_GRAPES: {
		FruitParams.MAIN_TEXTURE: "uid://cm1nj60d1c5rv",
		FruitParams.CHOPPED_TEXTURE: "uid://cjybmdxr41l0x",
		FruitParams.SINGLE_TEXTURE: "uid://cm1nj60d1c5rv",
		FruitParams.IS_ANIMATED: false,
		FruitParams.SPEED: 25,
		FruitParams.PATH_COMPLEXITY: 0
	},
	KEY_ALL_SEEING_CHERRY: {
		FruitParams.MAIN_TEXTURE: "uid://bphmskpwbpnsv",
		FruitParams.CHOPPED_TEXTURE: "uid://bnkk074p0dhop",
		FruitParams.SINGLE_TEXTURE: "uid://b5jttb4gpdhq4",
		FruitParams.IS_ANIMATED: true,
		FruitParams.SPEED: 15,
		FruitParams.PATH_COMPLEXITY: 0
	},
	KEY_COSMIC_WATERMELON: {
		FruitParams.MAIN_TEXTURE: "uid://caeunebcv8sgj",
		FruitParams.CHOPPED_TEXTURE: "uid://c80c8wbwubh8d",
		FruitParams.SINGLE_TEXTURE: "uid://cnju17kj1mg17",
		FruitParams.IS_ANIMATED: true,
		FruitParams.SPEED: 15,
		FruitParams.PATH_COMPLEXITY: 3
	}
}

const KEY_REQUIREMENTS: String = "requirements"
const KEY_FRUIT_NAME: String = "fruit_name"
const KEY_QTY: String = "qty"

const LEVELS: Dictionary = {
	1: {
		KEY_REQUIREMENTS: {
			1: {
				KEY_FRUIT_NAME: KEY_KIDNEY_GRAPES,
				KEY_QTY: 5
			},
			2: {
				KEY_FRUIT_NAME: KEY_ALL_SEEING_CHERRY,
				KEY_QTY: 5
			},
			3: {
				KEY_FRUIT_NAME: KEY_COSMIC_WATERMELON,
				KEY_QTY: 1
			},
		}
	}
}

# CHOPPING MINIGAME

# STIRRING MINIGAME
var stirring_ongoing = false

var current_chopped_hits: int = 0:
	set(new_value):
		current_chopped_hits = new_value
		SignalBus.chopping_happened.emit(new_value)

# KEYS
# Strings to organize the data into a Dictionary and later into a JSON
const KEY_GAME_VERSION: String = "game version"
const KEY_IS_NEW_GAME: String = "is new game"
const KEY_PROTOCOL_NUMBER: String = "protocol number"
const KEY_CURRENT_MINIGAME: String = "current_minigame"
enum Minigames {GRABBING, CHOPPING, STIRRING}
const KEY_CURRENT_LEVEL: String = "current level"
const KEY_GRABBING_TIME: String = "grabbing time"
const KEY_GRABBING_JUNK_AMT: String = "grabbing junk"
const KEY_SHOTS_FIRED: String = "shots fired"
const KEY_COLOR_PICKED: String = "color picked"
const KEY_REVOLUTIONS_DONE: String = "revolutions done"
const KEY_RESTARTS: String = "restarts"

# DEFAULT GAME DATA
# What to load into a new save
const DEFAULT_GAME_DATA: Dictionary = {
	KEY_GAME_VERSION: GAME_VERSION,
	KEY_IS_NEW_GAME: true, #TODO: change to false upon completing level 1
	KEY_PROTOCOL_NUMBER: "AA-12345",
	KEY_CURRENT_MINIGAME: Minigames.GRABBING,
	KEY_CURRENT_LEVEL: 1,
	KEY_GRABBING_TIME: 0.0,
	KEY_GRABBING_JUNK_AMT: 0,
	KEY_SHOTS_FIRED: 0,
	KEY_COLOR_PICKED: Color(0.831, 0.8, 0.434, 1.0),
	KEY_REVOLUTIONS_DONE: 0,
	KEY_RESTARTS: 0
}

# CURRENT GAME DATA
# Dictionary to load the current state of the game into, and to pass into SavesManager
# Also polling this every time I need to know something

var current: Dictionary = DEFAULT_GAME_DATA.duplicate_deep() # Defaults to base game data on load

func _ready() -> void:
	# Load and apply configuration
	SavesManager.load_config(config)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"),config[KEY_MUSIC_VOLUME]/100.00)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"),config[KEY_SFX_VOLUME]/100.00)

	SavesManager.load_save(current, active_save_slot)
	
func initiate_load_game_data() -> void:
	SavesManager.load_save(current, active_save_slot)

func initiate_save_game_data() -> void:
	SavesManager.save_game(current.duplicate_deep(), active_save_slot)

func calculate_final_grade() -> String:
	
	var grabbing_grade: int = calculate_grabbing_grade()
	var chopping_grade: int = calculate_chopping_grade()
	var stirring_grade: int = calculate_stirring_grade()
	
	var final_grade: int = (grabbing_grade+chopping_grade+stirring_grade)/3
	
	match final_grade:
		1: return "[color=0EB59C]S+[/color]"
		2: return "[color=23A6A3]S[/color]"
		3: return "[color=23A655]A[/color]"
		4: return "B"
		5: return "C"
		6: return "D"
		_: return "F"
	
func calculate_grabbing_grade() -> int:
	# Calculate timing grade
	var time_grade: int
	var sbase: float = 10.00
	var gap: float = 5.00
	var time: float = current[KEY_GRABBING_TIME]
	
	if time <= sbase:
		time_grade = 1
	elif time > sbase and time <= sbase+gap:
		time_grade = 2
	elif time > (sbase+(gap*1)) and time <= (sbase+(gap*2)):
		time_grade = 3
	elif time > (sbase+(gap*2)) and time <= (sbase+(gap*3)):
		time_grade = 4
	elif time > (sbase+(gap*3)) and time <= (sbase+(gap*5)):
		time_grade = 5
	elif time > (sbase+(gap*5)) and time <= (sbase+(gap*6)):
		time_grade = 6
	elif time > (sbase+(gap*6)):
		time_grade = 7
	
	# calculate junk grade:
	var junk_grade: int
	var junk_gap: int = 3
	var junk: int = current[KEY_GRABBING_JUNK_AMT]
	if junk == 0:
		junk_grade = 1
	elif junk > 0 and junk <= junk_gap:
		junk_grade = 2
	elif junk > junk_gap and junk <= junk_gap*2:
		junk_grade = 3
	elif junk > junk_gap*2 and junk <= junk_gap*3:
		junk_grade = 4
	elif junk > junk_gap*3 and junk <= junk_gap*4:
		junk_grade = 4
	elif junk > junk_gap*4 and junk <= junk_gap*5:
		junk_grade = 5
	elif junk > junk_gap*5 and junk <= junk_gap*6:
		junk_grade = 6
	elif junk > junk_gap*6:
		junk_grade = 7
	
	var final_grade: int = (time_grade + junk_grade)/2
	
	return final_grade
	
func calculate_chopping_grade() -> int:
	var laser_fired: int = current[KEY_SHOTS_FIRED]
	var sbase: int = 3
	var gap: int = 2
	
	if laser_fired <= sbase:
		return 1
	elif laser_fired > sbase and laser_fired <= sbase+gap:
		return 2
	elif laser_fired > sbase+gap and laser_fired <= sbase+(gap*2):
		return 3
	elif laser_fired > sbase+(gap*2) and laser_fired <= sbase+(gap*3):
		return 4
	elif laser_fired > sbase+(gap*3) and laser_fired <= sbase+(gap*4):
		return 5
	elif laser_fired > sbase+(gap*4) and laser_fired <= sbase+(gap*5):
		return 6
	else:
		return 7

func calculate_stirring_grade() -> int:
	var laser_fired: int = current[KEY_REVOLUTIONS_DONE]
	var fbase: int = 10
	var gap: int = 5
	
	if laser_fired <= fbase:
		return 7
	elif laser_fired > fbase and laser_fired <= fbase+gap:
		return 6
	elif laser_fired > fbase+gap and laser_fired <= fbase+(gap*2):
		return 5
	elif laser_fired > fbase+(gap*2) and laser_fired <= fbase+(gap*3):
		return 4
	elif laser_fired > fbase+(gap*3) and laser_fired <= fbase+(gap*4):
		return 3
	elif laser_fired > fbase+(gap*4) and laser_fired <= fbase+(gap*5):
		return 2
	else:
		return 1
