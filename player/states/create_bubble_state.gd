extends StateBase
class_name CreateBubbleState;

const SPEED = 64.0
const BUBBLE = preload("res://bubble/bubble.tscn")
var state: StateBase;
@onready var player: Player = $"../.."
@onready var left_detector: Area2D = $LeftDetector
@onready var right_detector: Area2D = $RightDetector
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func _state_enter_c(context: Dictionary):
	state = context["return_state"]
	animation_player.play("create_bubble")

func _state_physics_process_d(delta: float) -> void:
	var is_falling = player.fall(delta);
	if (is_falling and not player.bubble) or \
			Input.is_action_just_released("Bubble") or \
			Input.is_action_just_pressed("Jump"): 
		machine.change_state(state);
		return;
	if not player.bubble and player.global_position != player.cell:
		player.global_position = player.global_position.move_toward(player.cell, SPEED * delta) 
		return;

	if Input.is_action_just_pressed("Left"):
		player.direction = Vector2.LEFT;
		if _detect_obstacle(left_detector):
			_create_buble();
		return;
	if Input.is_action_just_pressed("Right"):
		player.direction = Vector2.RIGHT;
		if _detect_obstacle(right_detector):
			_create_buble();
		return;

func _detect_obstacle(detector: Area2D):
	return not detector.get_overlapping_areas()\
			.filter(func(body): return body is not Body or not body.bubble);

func _create_buble():
	var buble: Node2D = BUBBLE.instantiate()
	player.parent.add_child(buble)
	buble.global_position = player.cell + player.direction * Body.CELL_SIZE;
	
