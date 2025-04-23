@tool
extends Node2D

const sprite_width = 180
@onready var tree_sprite: Sprite2D = $TreeSprite
var habit : Habit
const DAY_SECONDS = 24 * 60 * 60 
var days_progressed

@export var new_sprite = false:
	set(new):
		new_sprite = new
		print("test")
		set_h_frames()

func _ready() -> void:
	set_h_frames()
	
func set_h_frames():
	if tree_sprite:
		var h_frames = tree_sprite.texture.get_width()/180
		tree_sprite.hframes = h_frames
	
func set_habit(habit_resource: Habit):
	habit = habit_resource
	%HabitLabel.text = habit_resource.habit
	determine_days_since_habit_started()
	var habit_unix_time = habit_resource.timestamp
	var unix_time_now = Time.get_unix_time_from_system()
	
	var days_free = habit_unix_time - unix_time_now
	var time = Time.get_time_dict_from_unix_time(days_free)
	print("time ", time)

func determine_days_since_habit_started():
	var unix_time_now = Time.get_unix_time_from_system()
	var time_since_habit_created = unix_time_now - habit.timestamp 
	days_progressed = int(time_since_habit_created/DAY_SECONDS)
	set_tree(days_progressed)
	

func add_day():
	days_progressed +=1
	set_tree(days_progressed)
	
func set_tree(days_progressed):
	set_h_frames()
	if days_progressed > tree_sprite.hframes:
		#max h_frames
		tree_sprite.frame = tree_sprite.hframes-1
	else:
		tree_sprite.frame = days_progressed
	
	
