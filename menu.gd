extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/start.grab_focus()
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_pressed():
	get_tree().change_scene("res://map.tscn")


func _on_options_pressed():
	get_tree().change_scene("res://optioins.tscn")

func _on_exit_pressed():
	get_tree().quit()
