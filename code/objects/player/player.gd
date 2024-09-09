extends CharacterBody2D


const move_distance = 1000
@export var tiles : TileMap

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -move_distance
		update_npc()
	if Input.is_action_just_pressed("ui_down"):
		update_npc()
		velocity.y = move_distance
	if Input.is_action_just_pressed("ui_left"):
		update_npc()
		velocity.x = -move_distance
	if Input.is_action_just_pressed("ui_right"):
		update_npc()
		velocity.x = move_distance

	move_and_slide()
	velocity.y = 0
	velocity.x = 0

func update_npc():
	get_tree().call_group("npc","_player_update")
