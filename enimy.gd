extends KinematicBody2D
export var is_attacking = false
var is_moving = true
var staying = false 
var health = 100
var attack = 20 
const UP = Vector2(0, -1)
const gravtiy = 10
const speed = 30
const Floor = Vector2(0, -1)
var velocity = Vector2()
var is_moving_right = true 
onready var player = get_node("root/map/player")
onready var edge_detector = $RayCast2D
var direction = 1 
var in_area = false

func _ready():
	edge_detector.enabled = true
	

	
func _physics_process(delta):
	print(in_area)
	


	if in_area == false and is_attacking == false and staying == false:
		velocity.x = speed * direction
	else:
		velocity.x = 0
	if direction == 1:
		$enimy.flip_h = false
	else:
		$enimy.flip_h = true
	
	if velocity.x > 0:
		$AnimationPlayer.play("moving")
	#GRAVITY CODE
	velocity.y += gravtiy
	
	#MOVE SPRITE
	if in_area == false:
		velocity = move_and_slide(velocity, Floor)
	
	if staying == true :
		is_moving = false
		in_area = true
		staying = true
		$AnimationPlayer.play("attack")
		print("aaaattakck")
		yield (get_node("AnimationPlayer"), "animation_finished")
		#is_attacking = false
	
	
	if not edge_detector.is_colliding():
		$hit_attack/attack.position.x *= -1
		direction *= -1
		edge_detector.position.x *= -1 
		$hit_attack/attx.position.x *= -1 
	
	if is_on_wall():
		$hit_attack/attack.position.x *= -1
		direction *= -1
		edge_detector.position.x *= -1 
		$hit_attack/attx.position.x *= -1 


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.global_position.x < global_position.x:
			direction =-1
			$hit_attack/attack.position.x *= direction 
			$hit_attack/attx.position.x *= direction
			edge_detector.position.x *= direction 
			 
		else:
			$hit_attack/attack.position.x *= direction 
			$hit_attack/attx.position.x *= direction
			edge_detector.position.x *= direction  
			 
			direction = 1
		pass
		



func _on_hit_attack_body_entered(body):
	if body.is_in_group("Player"):
		is_moving = false
		in_area = true
		staying = true
		$AnimationPlayer.play("attack")
		print("aaaattakck")
		yield (get_node("AnimationPlayer"), "animation_finished")
		#is_attacking = false
	


func _on_hit_attack_body_exited(body):
	if body.is_in_group("Player"):
		in_area = false
		staying = false



	
