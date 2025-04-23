extends Control

@onready var check_in_button: TextureButton = $ToolBar/CheckInButton
@onready var add_habit_button: TextureButton =$ToolBar/AddHabitButton
@onready var cancel_button: TextureButton = $ToolBar/CancelButton

@onready var habit_text_edit: TextEdit = $Prompt/ColorRect/VBoxContainer/HabitTextEdit
@onready var prompt: Control = $Prompt
@onready var submit_habit: Button = $Prompt/ColorRect/VBoxContainer/SubmitHabit

@onready var TreeScene: Node2D = $Tree


func _ready() -> void:
	submit_habit.pressed.connect(on_submit_habit)
	add_habit_button.pressed.connect(on_add_habit)
	load_habits()
	
func load_habits():
	var directory = DirAccess.open("user://")
	
	if !directory.dir_exists("Habits"):
		directory.make_dir("user://Habits/")
	
	var habits_dir_path = "user://Habits/"
	var habit_dir = DirAccess.open("user://Habits/")
	
	var files = habit_dir.get_files()
	
	if files.size() > 0:
		var habit_path = habits_dir_path + files[0]
		var habit: Habit = ResourceLoader.load(habit_path)
		TreeScene.set_habit(habit)
		print(files)
	
func on_submit_habit():
	if habit_text_edit.text != "":
		var habit_resource : Habit = Habit.new()
		
		habit_resource.habit = habit_text_edit.text
		habit_resource.timestamp = Time.get_unix_time_from_system()
		print(habit_resource.timestamp)
		
		var directory = DirAccess.open("user://")
		
		if !directory.dir_exists("Habits"):
			directory.make_dir("user://Habits/")

		var path = "user://Habits/" + habit_text_edit.text + ".tres"
		
		ResourceSaver.save(habit_resource, path)
	else:
		printerr("tried to submit empty string!")
	
func on_add_habit():
	prompt.visible = !prompt.visible
	

	
	
