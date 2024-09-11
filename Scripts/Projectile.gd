extends CharacterBody2D
class_name Projectile

@export var damage : float
@export var target : Enemy

@export var startPos : Vector2
@export var range : float

@export var speed : float = 150
@export var speedFalloff : float = 0.9

@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	if not is_instance_valid(target) : return
	
	rotateToTarget(target, delta)
	
	velocity = Vector2.ZERO	
	if target:
		velocity = position.direction_to(target.position) * speed
		velocity *= speedFalloff
	move_and_slide()
	if position.distance_to(startPos) > range:
		queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.hurt(damage)
		queue_free()

func rotateToTarget(target, delta):
	if not is_instance_valid(target): return
	
	var dir = target.global_position - global_position
	var angle = transform.x.angle_to(dir)
	rotate(sign(angle) * min(delta * 10, abs(angle)))


func _on_timer_timeout():
	queue_free()
