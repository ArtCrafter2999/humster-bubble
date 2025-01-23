extends CharacterBody2D
class_name Bubble;

const FLOATING_MODIFIER = 1.2
const INSIDE_FLOATING_MODIFIER = 4.8
var body_inside: Body
var _body_parent: Node
var _save_layer: int
var _save_mask: int

func _ready() -> void:
	var tree = get_tree();
	await tree.physics_frame;
	await tree.physics_frame;
	if not body_inside:
		collision_mask = 5;
	# TODO: bad approach, maybe fix later

func _physics_process(delta: float) -> void:
	if body_inside:
		velocity = -get_gravity() * delta * INSIDE_FLOATING_MODIFIER
		if is_on_ceiling() and body_inside.velocity:
			pop();
	else: 
		velocity = -get_gravity() * delta * FLOATING_MODIFIER
	move_and_slide()

func _process(delta: float) -> void:
	if body_inside and not is_on_ceiling():
		_fix_body();

func _fix_body():
	if(body_inside):
		body_inside.bubble = self;
		body_inside.velocity = Vector2.ZERO;
		body_inside.position = Vector2.ZERO;
		collision_layer = 1;
		collision_mask = 1;
		body_inside.collision_layer = 2
		body_inside.collision_mask = 0

func pop():
	if(body_inside):
		body_inside.bubble = null;
		body_inside.reparent(_body_parent)
		collision_layer = 4;
		collision_mask = 5;
		body_inside.collision_layer = _save_layer
		body_inside.collision_mask = _save_mask
		body_inside = null;
	queue_free();

func _on_object_detector_body_entered(other: Node2D) -> void:
	if other is Body and not body_inside:
		body_inside = other
		_body_parent = other.get_parent();
		other.reparent(self)
		_save_layer = body_inside.collision_layer;
		_save_mask = body_inside.collision_mask;
		_fix_body();

func _on_detector_body_entered(other: Node2D) -> void:
	if other != self:
		if other is Bubble and not other.body_inside:
			other.pop();
		if not body_inside:
			pop();
