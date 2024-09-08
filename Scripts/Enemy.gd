extends Node2D
class_name Enemy

@export var health : float = 10.0
@export var gold : int = 3

@export var sprite : Sprite2D

@export var movementSpeed : float = 10.0

func _init():
	pass

func moveToNextWaypoint(waypoint : Vector2):
	pass
