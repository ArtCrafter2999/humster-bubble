extends Body
class_name MovingBlock

const SPEED := 80.0

@onready var left_detector: Area2D = $LeftDetector
@onready var right_detector: Area2D = $RightDetector

func _physics_process(delta: float) -> void:
	fall(delta)
	move_and_slide()

func push(direction: Vector2):
	if direction == Vector2.LEFT:
		await _push_direction(direction, left_detector)
	elif direction == Vector2.RIGHT:
		await _push_direction(direction, right_detector)

func check_push(direction: Vector2):
	if direction == Vector2.LEFT:
		return _check_push(left_detector)
	elif direction == Vector2.RIGHT:
		return _check_push(right_detector)

func _check_push(detector: Area2D):
	if bubble and detector.get_overlapping_bodies():
		bubble.pop();
	return is_on_floor() or bubble

func _push_direction(direction: Vector2, detector: Area2D):
	if bubble: bubble.pop()
	if detector.get_overlapping_bodies(): return;
	var delta = 0
	var target = cell.x + direction.normalized().x * CELL_SIZE
	var tree = get_tree()
	while global_position.x != target:
		await tree.physics_frame;
		delta = get_physics_process_delta_time();
		global_position.x = move_toward(global_position.x, target, SPEED * delta)
	while not is_on_floor():
		await tree.physics_frame;
