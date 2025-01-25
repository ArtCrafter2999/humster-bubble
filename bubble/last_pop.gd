extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func last_pop():
	reparent(get_parent().get_parent())
	play()
	await get_tree().create_timer(1).timeout;
	queue_free();
