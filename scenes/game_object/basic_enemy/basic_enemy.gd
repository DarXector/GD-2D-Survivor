extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var velocity_component = $VelocityComponent


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	if velocity.normalized().x > 0:
		sprite.flip_h = false
	elif velocity.normalized().x < 0:
		sprite.flip_h = true