extends StateBase

@export var after_buble_state: StateBase
@export var buble_state: StateBase
@onready var player: Player = $"../.."
@onready var get_out_timer: Timer = $GetOutTimer
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func _process(delta: float) -> void:
	if player.bubble and machine.state is not CreateBubbleState:
		machine.change_state(self)

func _state_enter():
	animation_player.play("idle")

func _state_process():
	if not player.bubble:
		machine.change_state(after_buble_state)
	if _anything_pressed() and player.bubble.is_on_ceiling():
		if get_out_timer.is_stopped():
			get_out_timer.start();
	elif not get_out_timer.is_stopped():
		get_out_timer.stop();
		
	var axis := Input.get_axis("Left", "Right")
	if round(axis):
		player.direction = Vector2(round(axis), 0);
		
	if Input.is_action_just_pressed("Bubble"):
		machine.change_state(buble_state, {"return_state": self})

func _state_exit():
	get_out_timer.stop();

func _on_get_out_timer_timeout() -> void:
	player.bubble.pop();
	machine.change_state(after_buble_state)

func _anything_pressed():
	return Input.is_action_pressed("Right") or Input.is_action_pressed("Left")
