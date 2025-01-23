extends StateBase
class_name CreateBubbleState;

const SPEED = 64.0
const BUBBLE = preload("res://bubble/bubble.tscn")
@export var after_buble_state: StateBase
@onready var player: Player = $"../.."
@onready var left_detector: Area2D = $LeftDetector
@onready var right_detector: Area2D = $RightDetector

func _state_process_d(delta: float) -> void:
	if Input.is_action_just_released("Bubble") or \
			Input.is_action_just_pressed("Jump") or \
			(player.fall(delta) and not player.bubble):
		machine.change_state(after_buble_state)
		return;
	player.global_position = player.global_position.move_toward(player.cell, SPEED * delta) 
	if Input.is_action_just_pressed("Left"):
		player.direction = Vector2.LEFT;
		if not left_detector.get_overlapping_bodies():
			_create_buble();
		return;
	if Input.is_action_just_pressed("Right"):
		player.direction = Vector2.RIGHT;
		if not right_detector.get_overlapping_bodies():
			_create_buble();
		return;

func _create_buble():
	var buble: Node2D = BUBBLE.instantiate()
	player.parent.add_child(buble)
	buble.global_position = player.cell + player.direction * Body.CELL_SIZE;
	
