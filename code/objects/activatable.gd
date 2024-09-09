extends Node2D

@export var activated:bool = false

@export var defaultActive:bool = false

@export var activeFrame:int = 1

@export var inactiveFrame:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (activated == true): 
		$AnimatedSprite2D.set_frame_and_progress(activeFrame,1)
	else: 
		$AnimatedSprite2D.set_frame_and_progress(inactiveFrame,1)
