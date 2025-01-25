extends Node
class_name MainScene

@onready var level_manager: LevelManager = $LevelManager
@onready var main_menu: Control = $MainMenu
@onready var room_tone_audio: AudioStreamPlayer = $RoomToneAudio

func _input(event):
	if Input.is_action_just_pressed("Home"):
		back_to_main_menu();
		return;
	if Input.is_action_just_pressed("ResetLevel"):
		level_manager.reset_level();

func back_to_main_menu():
	room_tone_audio.stop();
	level_manager.close_level();
	main_menu.visible = true;

func select_level(level_index: int):
	room_tone_audio.play();
	level_manager.select_level(level_index);
	main_menu.visible = false
