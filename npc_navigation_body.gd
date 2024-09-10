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
	var nav_point = ray_cast_collision_point + ray_cast_collision_safe_offset
	var right_colliding = $Right.is_colliding()
	var left_colliding = $Left.is_colliding()
	var up_colliding = $Up.is_colliding()
	var down_colliding = $Down.is_colliding()
	var player = get_tree().get_nodes_in_group("player")[0]

	
	var x_colliding = left_colliding or right_colliding
	var y_colliding = up_colliding or down_colliding
	var cardinal_directions = {
		'up': Vector2(0,-16)+global_position,
		'down': Vector2(0,16)+global_position,
		'right': Vector2(16,0)+global_position,
		'left': Vector2(-16,0)+global_position
		
	}
	var relative_ghost_position: Vector2 = global_position-player.global_position

	print(relative_ghost_position)

	if x_colliding and !y_colliding:
		if (relative_ghost_position.y > 0 ):
			nav_point = cardinal_directions.down
		else:
			nav_point = cardinal_directions.up	
	elif y_colliding and !x_colliding:
		if (relative_ghost_position.x > 0 ):
			nav_point = cardinal_directions.right
		else:
			nav_point = cardinal_directions.left
	elif y_colliding and x_colliding:
		# Find the direction that is not colliding
		var possible_directions = []

		if !up_colliding:
			possible_directions.append(cardinal_directions.up)
		if !down_colliding:
			possible_directions.append(cardinal_directions.down)
		if !right_colliding:
			possible_directions.append(cardinal_directions.right)
		if !left_colliding:
			possible_directions.append(cardinal_directions.left)

		# Check which of the possible directions is furthest away from the player
		if possible_directions.size() > 0:
			var furthest_direction = possible_directions[0]
			var max_distance = player.global_position.distance_to(furthest_direction)
			
			for adirection in possible_directions:
				var adistance = player.global_position.distance_to(adirection)
				if adistance > max_distance:
					furthest_direction = adirection
					max_distance = adistance

			# Set the navigation point to the furthest direction
			nav_point = furthest_direction
		
		
	
	$DebugPot.global_position = nav_point
	$GlobalDebugPot.global_position = global_position
	$RayDebugPot.global_position = ray_cast_collision_point

	
	current_nav_path = tiles.get_navigation_path(global_position,nav_point)
	
