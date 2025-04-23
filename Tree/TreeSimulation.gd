@tool
extends Node2D

const sprite_width = 180
@onready var tree_sprite: Sprite2D = $TreeSprite

@export var new_sprite = false:
	set(new):
		new_sprite = new
		print("test")
		set_h_frames()

func set_h_frames():
	if tree_sprite:
		var h_frames = tree_sprite.texture.get_width()/180
		tree_sprite.hframes = h_frames
	
func set_habit(habit_resource: Habit):
	%HabitLabel.text = habit_resource.habit
	
	var habit_unix_time = habit_resource.timestamp
	var unix_time_now = Time.get_unix_time_from_system()
	
	var days_free = habit_unix_time - unix_time_now
	var time = Time.get_time_dict_from_unix_time(days_free)
	print("time ", time)
