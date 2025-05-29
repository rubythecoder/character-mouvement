extends CharacterBody2D
#exported variables----------------------------------------------------------
@export var buffer_time = .1
# const variables------------------------------------------------------------
const SPEED = 300.0
const JUMP_VELOCITY = -450.0
#variables---------------------------------------------------------------------
var jump_buffer = false
var buffer_timer = .2

# functions------------------------------------------------------------------
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor(): #this checks if the player perform an early jump if sojump buffering = true
			perform_jump()
		else:
			jump_buffer = true
			buffer_time = buffer_timer
	if jump_buffer:
		buffer_time -= delta
		if buffer_timer <= 0.0:
			jump_buffer = false
	if jump_buffer and is_on_floor():
		perform_jump()
		jump_buffer = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func perform_jump():
	velocity.y = JUMP_VELOCITY
