extends StateBase

@export var after_push_state: StateBase;
@onready var player: Player = $"../.."

func _state_enter_c(context: Dictionary):
	var block: MovingBlock = context["block"];
	var push_direction: Vector2 = context["direction"];
	player.reparent(block);
	await block.push(push_direction);
	if machine.state == self:
		machine.change_state(after_push_state);

func _state_physics_process_d(delta: float):
	if Input.is_action_just_pressed("Jump"):
		player.reparent(player.parent);
		if "jump" in after_push_state:
			after_push_state.jump();
		machine.change_state(after_push_state);

func _state_exit():
	player.reparent(player.parent);
