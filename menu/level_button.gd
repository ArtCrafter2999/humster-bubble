extends Button

@export var level_index: int = 0;
@export var main_scene: MainScene;

func _ready() -> void:
	pressed.connect(_on_clicked)

func _on_clicked():
	main_scene.select_level(level_index)
