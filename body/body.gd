extends CharacterBody2D
class_name Body

const CELL_SIZE = 20;
var is_in_bubble = false;
@export var collision: Node2D

var cell: Vector2:
	get:
		var half_cell = CELL_SIZE / 2;
		return Vector2( \
			snappedi(global_position.x - half_cell, CELL_SIZE) + half_cell, \
			snappedi(global_position.y - half_cell, CELL_SIZE) + half_cell);
	set(value):
		global_position = value;

func fall(delta):
	if is_in_bubble: return true;
	var is_falling = not is_on_floor()
	if is_falling:
		velocity += get_gravity() * delta
	if name == "MovingBlock2":
		print(position)
	return is_falling;
