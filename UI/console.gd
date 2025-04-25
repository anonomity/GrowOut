extends Control
@onready var tree: Node3D = $"../SubViewportContainer/SubViewport/Tree"


func _ready():
	GDConsole.create_command(add_day)

func add_day():
	tree.add_day()
