extends StaticBody2D

@export var is_oppened = false;
var _just_entered = false;
@onready var open_sprite: Sprite2D = $OpenSprite
@onready var close_sprite: Sprite2D = $CloseSprite
@onready var open_audio: AudioStreamPlayer = $OpenAudio
@onready var close_audio: AudioStreamPlayer = $CloseAudio

func _ready() -> void:
	_just_entered = true;
	if is_oppened:
		open();
	else:
		close();
	_just_entered = false;

func open():
	is_oppened = true;
	open_sprite.visible = true;
	close_sprite.visible = false;
	collision_layer = 0;
	if not _just_entered:
		open_audio.play()

func close():
	is_oppened = false;
	open_sprite.visible = false;
	close_sprite.visible = true;
	collision_layer = 7;
	if not _just_entered:
		close_audio.play()
