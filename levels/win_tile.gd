extends Area2D

signal next_level
const SPEED = 64.0
@export var player_move_position: Node2D
var _player: Player
var _player_in_center = false;

func _physics_process(delta: float) -> void:
	if not _player: return;
	if not _player_in_center:
		_player.global_position = _player.global_position.move_toward(global_position, SPEED * delta)
		if _player.global_position == global_position:
			_player_in_center = true;
		else: return;
	_player.global_position = _player.global_position.move_toward(\
			player_move_position.global_position, SPEED * delta)
	if _player.global_position == player_move_position.global_position:
		next_level.emit();
		_player.queue_free();

func _on_body_entered(body: Node2D) -> void:
	if _player: return;
	if body is Player:
		body.disable_state_machine();
		_player = body;
