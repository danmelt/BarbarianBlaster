extends Area3D

#@onready var turret_manager: Node3D = $TurretManager

@export var speed := 30.0
@export var damage := 25

var direction := Vector3.FORWARD

#func onready() -> void:
	#position = turret_manager.turret_base.global_position

func _physics_process(delta: float) -> void:
	position += direction * speed * delta 
	
func _on_timer_timeout() -> void:
	queue_free()

func set_start_origin(pos: Vector3) -> void:
	position = pos

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_area"):
		area.get_parent().current_health -= damage
		queue_free()
