extends CharacterBody2D

var nav_close_to_point_radius = 0.5
@export var tiles : TileMapLayer
var current_nav_path = []
var direction = Vector2()

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	
	index_points()
	
	if Input.is_action_just_pressed("click"):
		pathfind_to_mouse()

func is_at_point():
	if global_position.distance_to(current_nav_path.front()) < nav_close_to_point_radius:
		return true
	else: return false

func index_points():
	if !current_nav_path.is_empty():
		current_nav_path.pop_front()
		
		if !current_nav_path.is_empty():
			move_to_position(current_nav_path.front())


func move_to_position(new_position):
	global_position = new_position
	print(velocity)
	velocity = Vector2.ZERO

func pathfind_to_mouse():
	
	current_nav_path = tiles.get_navigation_path(global_position,get_global_mouse_position())
