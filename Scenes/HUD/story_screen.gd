extends Control



func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")	
