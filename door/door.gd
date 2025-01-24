extends Area2D

var is_oppened = false;
var _is_in_door = false;
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enter_sprite: Sprite2D = $EnterSprite
@onready var collision: CollisionShape2D = $Collision

func _ready() -> void:
	animation_player.play("default");
	animation_player.speed_scale = 0

func open():
	is_oppened = true;
	animation_player.play("default");
	animation_player.speed_scale = 1;
	collision.disabled = false;

func close():
	is_oppened = false;
	_is_in_door = false;
	animation_player.play("default");
	animation_player.speed_scale = -1;
	collision.disabled = true;
	enter_sprite.visible = false;


func _on_body_entered(body: Node2D) -> void:
	if is_oppened and body is Player:
		_is_in_door = true;
		enter_sprite.visible = true;
		

func _on_body_exited(body: Node2D) -> void:
	if _is_in_door and body is Player:
		_is_in_door = false;
		enter_sprite.visible = false;
