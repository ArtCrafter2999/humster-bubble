extends Body
class_name Player

@onready var sprite: Sprite2D = $Sprite
@onready var state_machine: StateMachine = $StateMachine
@onready var floor_detector: Area2D = $FloorDetector

var direction: Vector2 = Vector2.RIGHT
var parent: Node;

func _ready() -> void:
	parent = get_parent();

func _process(delta: float) -> void:
	sprite.flip_h = direction == Vector2.LEFT;

func fall(delta: float):
	var is_falling = super.fall(delta);
	if not is_falling:
		is_falling = not floor_detector.get_overlapping_bodies();
		if is_falling:
			velocity += get_gravity() * delta;
	return is_falling
