extends Node2D
class_name StateBase

var can_reenter: bool = false;

var machine: StateMachine;

func safe_enter(machine: StateMachine, context: Dictionary = {}):
	if self.machine != machine:
		self.machine = machine;
	_state_enter_c(context);
func _state_input(event: InputEvent):
	pass

func _state_enter_c(context: Dictionary):
	_state_enter();
func _state_enter():
	pass
	
func _state_process_d(delta: float):
	_state_process();
func _state_process():
	pass
	
func _state_physics_process_d(delta: float):
	_state_physics_process();
func _state_physics_process():
	pass

func _state_exit_c(context: Dictionary = {}):
	_state_exit();
func _state_exit():
	pass
