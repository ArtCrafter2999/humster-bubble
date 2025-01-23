extends Body
class_name Player

@onready var sprite: Sprite2D = $Sprite
@onready var state_machine: StateMachine = $StateMachine

var direction: Vector2 = Vector2.RIGHT
var parent: Node;

func _ready() -> void:
	parent = get_parent();

func _process(delta: float) -> void:
	sprite.flip_h = direction == Vector2.LEFT;
