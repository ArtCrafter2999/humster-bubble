extends StateBase

@export var cancel_state: StateBase;
@export var push_state: StateBase;
var _block: MovingBlock
var _push_direction: Vector2
@onready var push_timer: Timer = $PushTimer
@onready var left_detector: Area2D = $"../../LeftDetector"
@onready var right_detector: Area2D = $"../../RightDetector"
@onready var player: Player = $"../.."

func _state_enter_c(context: Dictionary): 
	_block = context["block"];
	_push_direction = context["direction"];
	push_timer.start();

func _state_physics_process_d(delta: float) -> void:
	if not player.is_on_floor():
		machine.change_state(cancel_state);
	if _push_direction == Vector2.LEFT:
		_check_cancel("Left", left_detector);
	elif _push_direction == Vector2.RIGHT:
		_check_cancel("Right", right_detector);
	if Input.is_action_just_pressed("Jump"):
		if "jump" in cancel_state:
			cancel_state.jump();
		machine.change_state(cancel_state);

func _state_exit():
	push_timer.stop();

func _check_cancel(action: String, detector: Area2D):
	var bodies = detector.get_overlapping_bodies();
	if Input.is_action_just_released(action) or \
			!bodies or \
			bodies[0] != _block or \
			!_block.check_push(_push_direction):
		machine.change_state(cancel_state)

func _on_push_timer_timeout():
	machine.change_state(push_state, {"block": _block, "direction": _push_direction })
