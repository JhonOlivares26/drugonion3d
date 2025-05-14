extends Node3D

# Configuración
var speed : float = 3.0
var direction : Vector3 = Vector3.RIGHT  # Mover hacia la derecha
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready():
	play_random_animation()
	start_direction_timer()

func _process(delta):
	# Solo movimiento horizontal (sin gravedad)
	global_translate(direction * speed * delta)

func play_random_animation():
	var animations = ["jump", "mixamo_com"]
	var random_anim = animations[randi() % animations.size()]
	
	animation_player.play(random_anim)
	await animation_player.animation_finished
	play_random_animation()  # Bucle infinito

func start_direction_timer():
	while true:
		await get_tree().create_timer(3.0).timeout
		direction *= -1  # Invierte dirección cada 3 segundos
		
# Añade al script original
var jump_height : float = 2.0
var is_jumping := false

func trigger_jump():
	if !is_jumping:
		is_jumping = true
		var start_pos = position.y
		# Animación de salto
		await animation_player.play("jump")
		is_jumping = false
