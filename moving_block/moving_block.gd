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
	print(position, is_on_floor(), detector.get_overlapping_bodies())
	return is_on_floor() and !detector.get_overlapping_bodies()

func _push_direction(direction: Vector2, detector: Area2D):
	if detector.get_overlapping_bodies(): return;
	var delta = 0
	var target = position + direction * CELL_SIZE
	var tree = get_tree()
	while position != target:
		await tree.physics_frame;
		delta = get_physics_process_delta_time();
		position = position.move_toward(target, SPEED * delta)
