extends Area2D

signal pressed
signal unpessed

@onready var sprite_pressed: Sprite2D = $SpritePressed
@onready var sprite_unpressed: Sprite2D = $SpriteUnpressed
@onready var pressed_audio: AudioStreamPlayer = $PressedAudio
@onready var unpressed_audio: AudioStreamPlayer = $UnpressedAudio

func _on_body_entered(body: Node2D) -> void:
	pressed.emit()
	sprite_pressed.visible = true;
	sprite_unpressed.visible = false;
	pressed_audio.play()

func _on_body_exited(body: Node2D) -> void:
	unpessed.emit()
	sprite_unpressed.visible = true;
	sprite_pressed.visible = false;
	unpressed_audio.play()
