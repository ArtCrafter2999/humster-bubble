extends StateBase

@onready var player: Player = $"../.."

func _process(delta: float) -> void:
	if player.bubble and machine.state is not CreateBubbleState:
		machine.change_state(self)
		# TODO Додати щоб вибратися з пузиря треба було тримати кнопку якийсь час
