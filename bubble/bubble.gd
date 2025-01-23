extends CharacterBody2D
class_name Bubble;

const FLOATING_MODIFIER = 1.5
const INSIDE_FLOATING_MODIFIER = 6.0
var body_inside: Body
var _body_parent: Node

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
		body_inside.is_in_bubble = true;
		body_inside.velocity = Vector2.ZERO;
		body_inside.position = Vector2.ZERO;
		if("disabled" in body_inside.collision):
			body_inside.collision.disabled = true;

func pop():
	if(body_inside):
		body_inside.is_in_bubble = false;
		body_inside.reparent(_body_parent)
		if("disabled" in body_inside.collision):
			body_inside.collision.disabled = false;
		body_inside = null;
	queue_free();

func _on_object_detector_body_entered(other: Node2D) -> void:
	if other is Body and not body_inside:
		body_inside = other
		_body_parent = other.get_parent();
		other.reparent(self)
		_fix_body();

func _on_detector_body_entered(other: Node2D) -> void:
	if other != self:
		if other is Bubble and not other.body_inside:
			other.pop();
		if not body_inside:
			pop();
