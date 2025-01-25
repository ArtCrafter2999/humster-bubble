extends SubViewport
class_name LevelManager

@export var levels: Array[PackedScene]
var current_level: Level;
var current_level_index: int = -1;
@onready var game_viewport: SubViewport = $GameViewport
@onready var levels_parent: Node2D = $"../Levels"
@onready var main_scene: MainScene = $".."

func next_level():
	var new_index = current_level_index + 1;
	if(new_index == levels.size()):
		main_scene.back_to_main_menu();
	else:
		select_level(new_index);

func select_level(index: int):
	current_level_index = index;
	set_level(levels[index])

func set_level(level: PackedScene) -> void:
	_close_level_if_present();
	current_level = level.instantiate();
	add_child(current_level)
	size = current_level.size * Body.CELL_SIZE;
	current_level.next_level.connect(next_level)

func reset_level():
	if current_level_index < 0: return;
	set_level(levels[current_level_index]);

func close_level():
	_close_level_if_present();
	current_level = null;
	current_level_index = -1;

func _close_level_if_present():
	if current_level:
		current_level.queue_free();
