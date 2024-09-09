extends CharacterBody2D


const move_distance = 500
@export var tiles : TileMap

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		update_npc()
		$Sprite2D.set_frame_and_progress(0,1)
		velocity.y = -move_distance
	if Input.is_action_just_pressed("ui_down"):
		update_npc()
		$Sprite2D.set_frame_and_progress(0,1)
		velocity.y = move_distance
	if Input.is_action_just_pressed("ui_left"):
		update_npc()
		$Sprite2D.set_frame_and_progress(2,1)
		velocity.x = -move_distance
	if Input.is_action_just_pressed("ui_right"):
		update_npc()
		$Sprite2D.set_frame_and_progress(1,1)
		velocity.x = move_distance

	move_and_slide()
	velocity.y = 0
	velocity.x = 0

func update_npc():
	get_tree().call_group("npc","_player_update")
