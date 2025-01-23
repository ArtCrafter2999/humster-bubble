extends StateBase

const SPEED = 80.0
const JUMP_FORCE = 200.0

@export var push_state: StateBase
@export var buble_state: StateBase

var _is_ceiled = false;

@onready var player: Player = $"../.."
@onready var left_detector: Area2D = $"../../LeftDetector"
@onready var right_detector: Area2D = $"../../RightDetector"
@onready var ceiling_detector: Area2D = $"../../CeilingDetector"
@onready var floor_detector: Area2D = $FloorDetector
@onready var push_timer: Timer = $PushTimer

func _state_physics_process_d(delta: float) -> void:
	var is_falling = player.fall(delta)
	if not is_falling:
		if Input.is_action_just_pressed("Jump"):
			jump();
	
	#if player.is_in_bubble and Input.is_action_just_pressed("Jump"):
		#player.is_in_bubble = false;
	
	var axis := Input.get_axis("Left", "Right")
	if axis:
		if axis < 0:
			_try_push(Vector2.LEFT, left_detector)
		if axis > 0:
			_try_push(Vector2.RIGHT, right_detector)
		player.velocity.x = axis * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	
	if(round(axis)):
		player.direction = Vector2(round(axis), 0);
		
	print(is_falling, player.is_in_bubble)
	if (not is_falling or player.is_in_bubble) and Input.is_action_just_pressed("Bubble"):
		machine.change_state(buble_state)

	player.move_and_slide()
	
func jump():
	if not ceiling_detector.get_overlapping_bodies():
		player.velocity.y = -JUMP_FORCE

func _try_push(direction: Vector2, detectorArea: Area2D):
	if not player.is_on_floor(): 
		return;
	var boddies: Array[MovingBlock];
	boddies.assign(detectorArea.get_overlapping_bodies() \
			.filter(func (body: Node2D): return body is MovingBlock))
	
	if(boddies.size() != 1):
		return;
	machine.change_state(push_state, {"block": boddies[0], "direction": direction })
