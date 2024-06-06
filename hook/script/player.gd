extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isHooking = false
var isComingBack = false
var enemyHooked = null

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if $hook.global_position.x - self.global_position.x > 300 || enemyHooked:
		isHooking = false
		isComingBack = true
		
	if $hook.global_position.x - self.global_position.x <= 5:
		isComingBack = false
		enemyHooked = null
		
	if isHooking and !enemyHooked:
		$hook.position.x += 1000 * delta
		
	if isComingBack:
		$hook.position.x -= 1000 * delta
		
	if enemyHooked:
		enemyHooked.position.x = $hook.global_position.x + 150
	
	# Handle hook.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !isHooking:
		isHooking = true
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y -= 500

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()


func _on_hook_body_entered(body):
	enemyHooked = body
