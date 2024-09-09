extends Node2D

@export var activatedNode: Node 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var area = $AnimatedSprite2D/PressureArea
	
	var overlappingBodies = area.get_overlapping_bodies()
	if (overlappingBodies.is_empty()):
		return
	var overlappingBody = overlappingBodies.front()
	
	if (overlappingBody and overlappingBody.is_in_group('npc')):
		$AnimatedSprite2D.set_frame_and_progress(1,1)
		if activatedNode:
			activatedNode.activated = !activatedNode.defaultActive
