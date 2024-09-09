extends CharacterBody2D

var nav_close_to_point_radius = 0.5
@export var tiles : TileMapLayer
var current_nav_path = []
var direction = Vector2()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var follower_or_not = false
@export var ray_size = 278
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var safteyOffset = 8

var is_dead = false

func _ready() -> void:
	pass

func complete_murder():
	queue_free()

func kill():
	is_dead = true
	animation_player.play("kill")

func _physics_process(delta: float) -> void:
	var player = get_tree().get_nodes_in_group("player")[0]
	ray_cast_2d.target_position = player.global_position.direction_to(global_position) * ray_size

func _player_update():
	if is_dead:
		return
	index_points()
	
	if follower_or_not:
		pathfind_to_player()
	else:
		pathfind_away_from_player()

func is_at_point():
	if global_position.distance_to(current_nav_path.front()) < nav_close_to_point_radius:
		return true
	else: return false

func index_points():
	if !current_nav_path.is_empty():
		current_nav_path.pop_front()
		
		if !current_nav_path.is_empty():
			move_to_position(current_nav_path.front())


func move_to_position(new_position:Vector2):
	global_position = new_position
	

func pathfind_to_player():
	var player = get_tree().get_nodes_in_group("player")[0]
	
	current_nav_path = tiles.get_navigation_path(global_position,player.global_position)

func pathfind_away_from_player():
	var ray_cast_collision_point = ray_cast_2d.get_collision_point()
	var ray_cast_collision_safe_offset = ray_cast_collision_point.direction_to(global_position) * safteyOffset
	var nav_point = ray_cast_collision_point + ray_cast_collision_safe_offset;
	print(nav_point)

	var direction = nav_point.direction_to(self.global_position)
	if $Left.is_colliding() or $Right.is_colliding():
		direction.x = 0
		direction.y 
		print(direction)
		nav_point = direction*32 + global_position

		
	if $Up.is_colliding() or $Down.is_colliding():
		direction.y = 0
		nav_point = direction*32 + global_position
		
		
	print(nav_point)
	print('')
		
	
	current_nav_path = tiles.get_navigation_path(global_position,nav_point)
	
