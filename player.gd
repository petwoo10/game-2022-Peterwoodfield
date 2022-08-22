extends KinematicBody2D


export (int) var speed = 120
export (int) var jumpspeed = -180
export (int) var gravity = 400
export (int) var rollspeed = 400
var is_attacking = false
var damage = 10
var direction = 36
var velocity = Vector2.ZERO
var is_rolling = false
var crouching = false
export (float) var friction = 10
export (float) var acceleration = 25

#enum state {IDLE,ROLL,STARTJUMP,ATTACK,DEATH,CROUCH,CROUCHATTACK,HIT,CROUCHWALK,RUN,JUMPFALL,JUMP}

#onready var player_state = state.IDLE
onready var state
onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready():
	state_machine.start("idle")
	pass

#func _on_AnimationPlayer_animation_finished(state_machine):
	#if state_machine == "attack":
		#is_attacking = false
		#state_machine.travel("jump")
#	if anim_name == "roll":
#		player_state = state.IDLE
#		is_rolling = false

#func update_animation(anim):
#	if velocity.x < 0:
#		$AnimatedSprite.flip_h = true
#	elif velocity.x > 0:
#		$AnimatedSprite.flip_h = false
		
#	match(anim):
#		state.JUMPFALL:
#			$AnimationPlayer.play("jumpfall")
#		state.ATTACK:
#			$AnimationPlayer.play("attack")
#			yield($AnimationPlayer,"animation_finished")
#			player_state = state.IDLE
#		state.ROLL:
#			$AnimationPlayer.play("roll")
#		state.CROUCH:
#			$AnimationPlayer.play("crouch")
#		state.CROUCHWALK:
#			$AnimationPlayer.play("crouchwalk")
#		state.CROUCHATTACK:
#			$AnimationPlayer.play("crouchattack")
#		state.RUN:
#			$AnimationPlayer.play("run")
#		state.HIT:
#			$AnimationPlayer.play("hit")
#		state.DEATH:
#			$AnimationPlayer.play("death")
#		state.IDLE:
#			$AnimationPlayer.play("idle")
#		state.JUMP:
#			$AnimationPlayer.play("jump")
			
		
	
#func handle_state(player_state):
#	match(player_state):
#		state.STARTJUMP:
#			velocity.y = jumpspeed
#	pass
	
	
func get_input():
	var dir = 0
	if not is_attacking:
		dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	
#	if is_currently_attacking == true:
#		velocity.x = 0
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir*speed, acceleration)
		
	else:
		velocity.x = 0#move_toward(0, 0, friction)
		
	if  Input.is_action_just_pressed("jump") and is_on_floor() and state_machine.get_current_node() != "roll":
		state_machine.travel("jump")
		velocity.y = jumpspeed
		
	if Input.is_action_just_pressed("roll") and is_on_floor():
		state_machine.travel("roll")
	
	elif velocity.x !=0 :#and state_machine.get_current_node() != "roll":
		if not crouching : state_machine.travel("run")
		else: state_machine.travel("crouchwalk")
			
	
		
	if Input.is_action_just_pressed("attack") and velocity.x == 0:
		print("sgfg")
		is_attacking = true
		state_machine.travel("attack")
		if crouching == true and Input.is_action_just_pressed("attack"):
			state_machine.travel("crouchattack")
			
			
	
		#if -30 <= velocity.x and velocity.x <= 30:
		#	velocity.x = 0
		#	state_machine.travel("idle")
	#if Input.is_action_just_released("attack"):
	#	state_machine.travel
	
	
func _physics_process(delta):
	
		
	
	#print(state_machine.get_current_node())
	if state_machine.get_current_node() != "roll":
		is_rolling = false
	#if state_machine. != "roll":
	#	is_rolling = false
	get_input()
	#print(is_on_floor())
	if Input.is_action_just_pressed("crouch"):
		state_machine.travel("crouch")
		crouching = true
	elif velocity == Vector2.ZERO:
		if not crouching : state_machine.travel("idle")
		else: state_machine.travel("crouch")
	
	if Input.is_action_just_released("crouch"):
		crouching = false
		
	#if Input.is_action_just_pressed("jump") and is_on_floor() and state_machine.get_current_node() != "roll":
	#	state_machine.travel("jump")
	#	velocity.y = jumpspeed
	#elif velocity.x !=0 and state_machine.get_current_node() != "roll":
	#	state_machine.travel("run")
	#elif velocity.x != 0 and Input.is_action_just_pressed("roll") and is_on_floor():
	#	state_machine.travel("roll")
	#	if -30 <= velocity.x and velocity.x <= 30:
	#		velocity.x = 0
	#		state_machine.travel("idle")
	#	elif velocity.x != 0 and Input.is_action_just_pressed("roll"):
	#		state_machine.travel("roll")
	#		
	#	elif velocity.x !=0 and state_machine.get_current_node() != "roll":
	#		state_machine.travel("run")
			
	#if state_machine.get_current_node() != "roll" and state_machine.get_current_node() != "attack":
	#	get_input()
		
	
		
		
		#if is_on_floor() and player_state != state.ROLL:
		#	if Input.is_action_just_pressed("jump"):
		#		velocity.y = jumpspeed
		#		player_state = state.JUMP
				
				
		
		
	if not is_on_floor():
		if velocity.y < 0:
			state_machine.travel("jump")
		if velocity.y > 0:
			state_machine.travel("jumpfall")
			
			
			
			
			
	#handle_state(player_state)
	#update_animation()
	
	
	
	#set gravysty 
	#if is_attacking == true:
	#	velocity.x = 0
	
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
		$"hit area/hit".position.x = -direction
	elif velocity.x > 0:
		$AnimatedSprite.flip_h = false
		$"hit area/hit".position.x = direction
	
	#if is_attacking == true:
	#	velocity.x = 0
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	$AnimationTree["parameters/conditions/is attack"] = is_attacking

	




#func _on_AnimationPlayer_animation_started(anim_name):
#	if anim_name == "roll":
#		is_rolling = true
		



func _on_hit_area_body_entered(body):
	if body.is_in_group("enimey") and is_attacking == true:
		body.deal_damage()
