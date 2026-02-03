extends RigidBody3D
@onready var bat_model_inherited: Node3D = $bat_model_inherited

func take_damage():
	bat_model_inherited.hurt()
