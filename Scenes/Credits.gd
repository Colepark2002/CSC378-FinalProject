extends Control



func _process(_delta):
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://Scenes/HUD/main_menu.tscn")	
