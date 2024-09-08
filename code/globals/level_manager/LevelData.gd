extends Object

class_name LevelData
var name: String
var scene: PackedScene
var order: int
var difficulty: String

func _init(name: String, scene: PackedScene, order: int, difficulty: String):
	self.name = name
	self.scene = scene
	self.order = order
	self.difficulty = difficulty
