extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const SPEED = 130.0
#player movement state machine
enum States {IDLE, RUNNING, JUMPING, FALLING}
var state: States = States.IDLE
func set_state(new_state: int) -> void:
	match new_state:
		0:
			animated_sprite_2d.play("idle")
		1:
			animated_sprite_2d.play("running")
		2:
			animated_sprite_2d.play("jumping")
		3:
			animated_sprite_2d.play("falling")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
		set_state(States.RUNNING)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		set_state(States.IDLE)
		
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	move_and_slide()
