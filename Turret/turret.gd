extends Node3D

@export var projectile: PackedScene
@export var turret_range := 12.0

var enemy_path: Path3D
var enemy: PathFollow3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cannon: Node3D = $TurretBase/TurretTop/Cannon
@onready var turret_base: Node3D = $TurretBase

func _physics_process(_delta: float) -> void:
	enemy = find_best_target()
	if enemy:
		turret_base.look_at(enemy.global_position, Vector3.UP, true)
	
func _on_timer_timeout() -> void:
	if enemy:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = cannon.global_position
		shot.direction = turret_base.global_transform.basis.z	
		animation_player.play("recoil")

func find_best_target() -> PathFollow3D:
	var best_target = null	
	var best_progress: int = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			var distance = global_position.distance_to(enemy.global_position)
			if enemy.progress > best_progress and distance <= turret_range:
				best_target = enemy
				best_progress = enemy.progress
	
	return best_target
	
	
	
