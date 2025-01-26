extends Button
class_name LevelButton

@export var level_index: int = 0:
	get:
		return level_index;
	set(value):
		text = str(value + 1);
		level_index = value;
@export var main_scene: MainScene;
@onready var hover_audio: AudioStreamPlayer = $HoverAudio
@onready var click_audio: AudioStreamPlayer = $ClickAudio

func _ready() -> void:
	
	pressed.connect(_on_clicked)
	mouse_entered.connect(_hover)
	mouse_exited.connect(_hover)

func _hover():
	hover_audio.play();

func _on_clicked():
	click_audio.play();
	main_scene.select_level(level_index)
