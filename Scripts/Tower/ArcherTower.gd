extends Tower

@export var arrow : PackedScene 
@export var damage : Vector2 = Vector2(5, 8)

var enemies : Array

@onready var timer = $Timer
@onready var collision_shape_2d : CollisionShape2D = $AttackRange/CollisionShape2D

func attack(enemy : Enemy):
	var projectile : Projectile = arrow.instantiate()
	projectile.damage = randi_range(damage.x , damage.y)
	projectile.position = global_position
	projectile.target = enemy
	projectile.startPos = global_position
	projectile.range = collision_shape_2d.shape.radius
	get_parent().add_child(projectile)

func _on_attack_range_body_entered(body):
	if body.is_in_group("Enemy"):
		print("Enemy found at pos: %s, name: %s" % [body.position, body.name])
		enemies.append(body)
		if enemies.size() == 1:
			timer.start()

func _on_attack_range_body_exited(body):
	if enemies.has(body):
		enemies.erase(body)

func _on_timer_timeout():
	if not enemies.is_empty():
		var e = enemies[0]
		attack(e)
		timer.start()
	
