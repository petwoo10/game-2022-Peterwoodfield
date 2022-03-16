extends Camera2D

var target = null
var zoomed = false
var center = Vector2.ZERO



func _ready():
	center = get_viewport_rect().size/2
	target = owner.get_node("player")
	global_position = target.global_position
	zoom = Vector2(0.5,0.5)
	
func _process(delta):
	pass
		
		
		#zoom = zoom.move_toward(Vector2(1,1),0.03)
		#osition = position.move_toward(center,80)
