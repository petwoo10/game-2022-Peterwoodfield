extends Control

var mute = false 
onready var music = $VBoxContainer/sound
onready var current 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_back_pressed():
	get_tree().change_scene("res://menu.tscn")


func _on_mute_pressed():
	if mute == true:
		mute = false 
		music.value = current
	elif mute == false:
		current = music.value
		mute = true
		music.value = 0
		
