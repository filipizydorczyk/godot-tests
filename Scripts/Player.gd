extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumps = 2

func _physics_process(delta):
	var direction = Input.get_axis("game_action_left", "game_action_right")
	var movement_velocity = direction * SPEED

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps = 2

	if Input.is_action_just_pressed("game_action_up") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		
	if Input.is_action_just_pressed("game_action_shoot"):
		__spawn_a_ball()

	if Input.is_action_just_pressed("game_action_super_movement"):
		var dash_direction = 1 if direction == 0 else direction
		velocity.x = dash_direction * (SPEED * 8)

	if direction and abs(velocity.x) <= abs(movement_velocity):
		velocity.x = movement_velocity
		animation.flip_h = direction > 0;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_high_jump_area_body_entered(body):
	velocity.y = JUMP_VELOCITY * 2

func __spawn_a_ball():
	var ball = load("res://Entities/Ball.tscn")
	var instance = ball.instantiate()
	instance.set_position(self.position + Vector2(0, -50))
	get_tree().get_current_scene().call_deferred("add_child", instance)
	
