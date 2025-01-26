extends Body
class_name MovingBlock

const SPEED := 80.0
var _is_pushing := false;
var _prev_falling := false;
var _just_enter := false;
@onready var left_detector: Area2D = $LeftDetector
@onready var right_detector: Area2D = $RightDetector
@onready var drop_audio: AudioStreamPlayer = $DropAudio

func _ready() -> void:
	_just_enter = true;
	await get_tree().physics_frame;
	await get_tree().physics_frame;
	await get_tree().physics_frame;
	await get_tree().physics_frame;
	_just_enter = false;

func _physics_process(delta: float) -> void:
	var is_falling = fall(delta)
	if not is_falling and _prev_falling and not _just_enter:
			drop_audio.play();
	_prev_falling = is_falling
	move_and_slide()

func push(direction: Vector2):
	if direction == Vector2.LEFT:
		await _push_direction(direction, left_detector, right_detector)
	elif direction == Vector2.RIGHT:
		await _push_direction(direction, right_detector, left_detector)

func check_push(direction: Vector2):
	if direction == Vector2.LEFT:
		return _check_push(left_detector)
	elif direction == Vector2.RIGHT:
		return _check_push(right_detector)

func _check_push(detector: Area2D):
	if bubble and detector.get_overlapping_bodies():
		bubble.pop();
	return is_on_floor() or bubble

func _push_direction(direction: Vector2, detector: Area2D, other_detector: Area2D):
	if bubble: bubble.pop()
	if detector.get_overlapping_bodies(): return;
	var delta = 0
	var target = cell.x + direction.normalized().x * CELL_SIZE
	var tree = get_tree()
	while global_position.x != target:
		await tree.physics_frame;
		delta = get_physics_process_delta_time();
		global_position.x = move_toward(global_position.x, target, SPEED * delta)
	while not is_on_floor() and not other_detector.get_overlapping_bodies().filter(_not_player):
		await tree.physics_frame;

func _not_player(body: Node):
	return body is not Player and body != self 
