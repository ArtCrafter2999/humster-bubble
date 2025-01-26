extends SubViewport
class_name LevelManager

const LEVEL_BUTTON = preload("res://menu/level_button.tscn")
@export var levels: Array[PackedScene]
var current_level: Level;
var current_level_index: int = -1;
@onready var game_viewport: SubViewport = $GameViewport
@onready var levels_parent: Node2D = $"../Levels"
@onready var main_scene: MainScene = $".."
@onready var level_end_audio: AudioStreamPlayer = $LevelEndAudio
@onready var level_restart_audio: AudioStreamPlayer = $LevelRestartAudio
@onready var level_list: GridContainer = $"../MainMenu/LevelList"

func _ready() -> void:
	for i in levels.size():
		var button: LevelButton = LEVEL_BUTTON.instantiate();
		button.level_index = i;
		button.main_scene = main_scene;
		level_list.add_child(button);

func next_level():
	var new_index = current_level_index + 1;
	level_end_audio.play();
	if(new_index == levels.size()):
		main_scene.back_to_main_menu();
	else:
		_safe_close_level();
		select_level(new_index);

func select_level(index: int):
	current_level_index = index;
	_safe_close_level()
	set_level(levels[index])

func set_level(level: PackedScene) -> void:
	current_level = level.instantiate();
	add_child(current_level)
	size = current_level.size * Body.CELL_SIZE;
	current_level.next_level.connect(next_level)

func reset_level():
	if current_level_index < 0: return;
	level_restart_audio.play();
	_force_close_level();
	set_level(levels[current_level_index]);

func close_level():
	_safe_close_level();
	current_level = null;
	current_level_index = -1;

func _force_close_level():
	if is_instance_valid(current_level):
		current_level.free();
		
func _safe_close_level():
	if is_instance_valid(current_level):
		current_level.queue_free();
