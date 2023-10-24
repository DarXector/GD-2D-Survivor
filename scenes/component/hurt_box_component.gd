extends Area2D
class_name HurtBoxComponent


@export var health_cpomoenent: Node


func _ready():
	area_entered.connect(ona_area_entered)


func ona_area_entered(other_area:Area2D):
	if not other_area is HitBoxComponent: return
	if health_cpomoenent == null: return
	
	var hit_vox_cpomonent = other_area as HitBoxComponent
	health_cpomoenent.damage(hit_vox_cpomonent.damage)
