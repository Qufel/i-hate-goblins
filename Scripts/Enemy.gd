extends CharacterBody2D
class_name Enemy

@export var health : float = 10.0
@export var gold : int = 3

@export var movementSpeed : float = 10.0
@export var acceleration : float = 3.0

@onready var nav = $NavigationAgent2D
@export var end : Node2D

@onready var animated_sprite_2d = $AnimatedSprite

@export_group("Flags")
@export var canMove : bool = true

func _physics_process(delta):
	if canMove:
		moveToPoint(delta)
	if isDead():
		die()
	
func moveToPoint(delta : float):
	
	await get_tree().physics_frame
	
	var dir : Vector2 = Vector2()
	nav.target_position = end.global_position
	
	dir = nav.get_next_path_position() - global_position
	dir = dir.normalized()
	
	chooseAnimation(dir)
	
	velocity = velocity.lerp(dir * movementSpeed, acceleration * delta)
	
	move_and_slide()
	
	if nav.is_target_reached():
		print("Reached end")
		queue_free()

func chooseAnimation(dir : Vector2):
	dir.x = round(dir.x)
	dir.y = round(dir.y)
	
	if dir.x == 1:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("MoveSide")
	elif dir.x == -1:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("MoveSide")
	elif dir.y == 1:
		animated_sprite_2d.play("MoveDown")
	elif dir.y == -1:
		animated_sprite_2d.play("MoveUp")

func die():
	print("Killed %s" % name)
	# TODO add gold/resources to player
	# TODO play death animation
	queue_free()

func hurt(damage : float):
	health -= damage

func isDead():
	return health <= 0
