extends CharacterBody2D
class_name Enemy

@export var health : float = 10.0
@export var gold : int = 3

@export var movementSpeed : float = 10.0
@export var acceleration : float = 3.0

@onready var nav = $NavigationAgent2D
@export var end : Node2D

func _physics_process(delta):
	moveToPoint(delta)
	
func moveToPoint(delta : float):
	
	await get_tree().physics_frame
	
	var dir : Vector2 = Vector2()
	nav.target_position = end.global_position
	
	dir = nav.get_next_path_position() - global_position
	dir = dir.normalized()
	
	velocity = velocity.lerp(dir * movementSpeed, acceleration * delta)
	
	move_and_slide()
