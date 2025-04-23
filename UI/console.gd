extends Control
@onready var tree: Node2D = $"../Tree"

func _ready():
	GDConsole.create_command(add_day)

func add_day():
	tree.add_day()
