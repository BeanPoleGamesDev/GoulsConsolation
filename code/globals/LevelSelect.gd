extends Control

@export var levelsPerPage = 8

const navButton = preload("res://code/globals/nav_button.tscn")
const levelPage = preload("res://code/globals/LevelsPage.tscn")
var levels
var x_translate
var xChange

func _ready():
	levels = LevelManager.get_levels()
	xChange = ProjectSettings.get_setting("display/window/size/viewport_width")
	x_translate = 144 + ProjectSettings.get_setting("display/window/size/viewport_height")
	var page = levelPage.instantiate()
	$PagesContainer.add_child(page)
	var i = 0

	for level in levels:
		i += 1
		if i > levelsPerPage:
			i = 1
			var ogPos = page.position
			page = levelPage.instantiate()
			page.rect_position = ogPos + Vector2(x_translate,40)
			$PagesContainer.add_child(page)
		
		var levelButton = navButton.instantiate()
		levelButton.set('scene', level.scene)
		levelButton.set('text', level.name.capitalize())
		page.add_child(levelButton)

func nextPage():
	for page in $PagesContainer.get_children():
		page.position -= Vector2(xChange,0)

func lastPage():
	for page in $PagesContainer.get_children():
		page.position += Vector2(xChange,0)
		
			
