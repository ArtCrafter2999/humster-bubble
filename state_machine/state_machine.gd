extends Node2D
class_name StateMachine

@export var begining_state: StateBase

var state: StateBase = null;

func _ready() -> void:
	var states = find_children("*", "StateBase", true, false) as Array[StateBase]
	for state in states:
		state.machine = self
	child_entered_tree.connect(on_child_entered_tree)
	if begining_state:
		change_state(begining_state)

func _input(event: InputEvent) -> void:
	if !state: return
	state._state_input(event);

func _process(delta: float) -> void:
	if !state: return
	state._state_process_d(delta);
	
func _physics_process(delta: float) -> void:
	if !state: return
	state._state_physics_process_d(delta)

func on_child_entered_tree(node: Node):
	if "machine" in node:
		node.machine = self;

func change_state(new_state: StateBase, context: Dictionary = {}):
	if state == new_state && !state.can_reenter:
		return;
	if state:
		await state._state_exit_c(context);
	state = new_state
	state.safe_enter(self, context);
