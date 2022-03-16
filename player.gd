extends KinematicBody2D


export (int) var speed = 120
export (int) var jumpspeed = -180
export (int) var gravity = 400
export (int) var rollspeed = 400

var velocity = Vector2.ZERO

export (float) var friction = 10
export (float) var acceleration = 25

enum state {IDLE,ROLL,STARTJUMP,ATTACK,DEATH,CROUCH,CROUCHATTACK,HIT,CROUCHWALK,RUN,JUMPFALL,JUMP}

onready var player_state = state.IDLE

func _ready():
	$AnimationPlayer.play("idle")
	pass
	
func update_animation(anim):
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite.flip_h = false
		
	match(anim):
		state.JUMPFALL:
			$AnimationPlayer.play("jumpfall")
		state.ATTACK:
			$AnimationPlayer.play("attack")
		state.ROLL:
			$AnimationPlayer.play("roll")
		state.CROUCH:
			$AnimationPlayer.play("crouch")
		state.CROUCHWALK:
			$AnimationPlayer.play("crouchwalk")
		state.CROUCHATTACK:
			$AnimationPlayer.play("crouchattack")
		state.RUN:
			$AnimationPlayer.play("run")
		state.HIT:
			$AnimationPlayer.play("hit")
		state.DEATH:
			$AnimationPlayer.play("death")
		state.IDLE:
			$AnimationPlayer.play("idle")
		state.JUMP:
			$AnimationPlayer.play("jump")
			
		
	
func handle_state(player_state):
	match(player_state):
		state.STARTJUMP:
			velocity.y = jumpspeed
	pass
	
	
func get_input():
	var dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir*speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		
	
	
	
func _physics_process(delta):
	get_input()
	print(is_on_floor())
	if velocity == Vector2.ZERO:
		player_state = state.IDLE
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_state = state.STARTJUMP
	elif velocity.x !=0:
		player_state = state.RUN
	
		if velocity.x == 0:
			player_state = state.IDLE
		elif velocity.x != 0 and Input.is_action_just_pressed("roll"):
			player_state = state.ROLL
		elif velocity.x !=0:
			player_state = state.RUN
		
		if is_on_floor() and player_state != state.ROLL:
			if Input.is_action_just_pressed("roll"):
				velocity.y = jumpspeed
				player_state
		
		
	if not is_on_floor():
		if velocity.y < 0:
			player_state = state.JUMP
		if velocity.y > 0:
			player_state = state.JUMPFALL
			
			
			
			
			
	handle_state(player_state)
	update_animation(player_state)
	#set gravysty 
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)


