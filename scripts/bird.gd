extends CharacterBody2D

const speed = 300.0
const JUMP_VELOCITY = -350.0
var gravity = 980

signal justdie

var isdead = false
var didStartGame = false

@onready var bird_animation = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if get_slide_collision_count() != 0: # Verifica quantos objetos colidiram com o personagem
		die()
	
	#Adiciona Gravidade
	if not is_on_floor() and didStartGame:
		velocity.y += gravity * delta
	
	move_and_slide()
	rotate_bird()

func jump():
	velocity.y = JUMP_VELOCITY

func die():
	if isdead == false:
		isdead = true
		bird_animation.stop()
		emit_signal("justdie")
		set_collision_mask_value(2, false)
		
	
func _on_main_didtouch() -> void:
	Handletoutch()

func Handletoutch():
	if not didStartGame:
		didStartGame = true
	if isdead == false:
		rotation = 0
		jump()
		
func rotate_bird():
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += 2 * deg_to_rad(1.4)
	if velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation -= 2 * deg_to_rad(1.2)
	
func _ready() -> void:
	pass 
	
	
	
func _process(delta: float) -> void:
	pass
	
	
	
	
