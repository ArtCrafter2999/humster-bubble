extends Node
class_name MainScene

@onready var level_manager: LevelManager = $LevelManager
@onready var main_menu: Control = $MainMenu

func _input(event):
	if Input.is_action_just_pressed("Home"):
		back_to_main_menu();
		return;
	if Input.is_action_just_pressed("ResetLevel"):
		level_manager.reset_level();

func back_to_main_menu():
	level_manager.close_level();
	main_menu.visible = true;

func select_level(level_index: int):
	level_manager.select_level(level_index);
	main_menu.visible = false
