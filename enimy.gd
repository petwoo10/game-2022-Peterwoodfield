extends KinematicBody2D

var health = 100
var attack = 20 
const UP = Vector2(0, -1)
const gravtiy = 10
const speed = 30
const Floor = Vector2(0, -1)
var velocity = Vector2()


var direction = 1 
func _ready():
	pass
	
	
	
func _physics_process(delta):
	velocity.x = speed * direction
	
	if direction == 1:
		$enimy.flip_h = false
		
	else:
		$enimy.flip_h = true
	$enimy.play("moving")
	
	velocity.y += gravtiy
	
	velocity = move_and_slide(velocity, Floor)
	
	if is_on_wall():
		direction = direction * -1
	


func _on_Area2D_body_entered(body):
	if player.tscn 
