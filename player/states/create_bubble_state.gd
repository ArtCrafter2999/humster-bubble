extends StateBase

const BUBBLE = preload("res://bubble/bubble.tscn")
@export var after_buble_state: StateBase
@onready var player: Player = $"../.."

func _state_enter_c(context: Dictionary):
	var buble: Node2D = BUBBLE.instantiate()
	player.parent.add_child(buble)
	buble.global_position = player.cell + player.direction * Body.CELL_SIZE;
	machine.change_state(after_buble_state)
