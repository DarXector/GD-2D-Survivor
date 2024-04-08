extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var velocity_component = $VelocityComponent

var is_moving = false

func _ready():
	$HurtBoxComponent.hit.connect(on_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()
	
	velocity_component.move(self)

	if velocity.normalized().x > 0:
		sprite.flip_h = false
	elif velocity.normalized().x < 0:
		sprite.flip_h = true


func set_is_moving(moving):
	is_moving = moving



func on_hit():
	$HitRandomAudioPlayer2DComponent.play_random()