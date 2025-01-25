extends Node
class_name Level

signal next_level
@export var size: Vector2i

func on_next_level():
	next_level.emit();
