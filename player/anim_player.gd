extends CharacterBody2D


@export var speed = 300.0
@export var jump_speed := -1000.0
@export var gravity := 2500.0
@onready var sprite = $PlayerSprite
@onready var sound = $PlayerSound
@onready var timer = $DelayTimer
@onready var shoot = $Shoot as AudioStreamPlayer

var is_s_pressed: bool = false
var is_r_pressed: bool = false
var is_space_pressed: bool = false
var is_mouse_button_pressed: bool = false

signal jumped

func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func get_side_input():	
	velocity.x = 0
	var vel := Input.get_axis("left", "right")
	var jump := Input.is_action_just_pressed('jump')

	if is_on_floor() and jump:
		velocity.y = jump_speed

		get_tree().call_group("HUD", "updateScore")
		
		# Reproduz o som de pulo
		sound.play()
		
	velocity.x = vel * speed
	
func animate():
	sprite.scale = Vector2(2, 2)
	
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		
		
# Função chamada quando a cena estiver pronta
func _ready():
	set_process_input(true)

# Função chamada a cada evento de entrada
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_S:
			if sprite.animation == "right":
				sprite.play("down")
			elif sprite.animation == "left":
				sprite.play("downLeft")
			else:
				sprite.play("down")
		if event.pressed and event.keycode == KEY_R:
			sprite.play("reload")
			await get_tree().create_timer(0.5).timeout
			sprite.play("right")
		if event.pressed and event.keycode == KEY_SPACE:
			sprite.play("up")
			await get_tree().create_timer(0.8).timeout
			sprite.play("right")
		if event.pressed and event.keycode == KEY_W:
			sprite.play("upMira")
			await get_tree().create_timer(0.8).timeout
			sprite.play("right")
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			shoot.play()
			if sprite.animation == "right":
				sprite.play("shoot")
				await get_tree().create_timer(0.3).timeout
				sprite.play("right")
			elif sprite.animation == "down":
				sprite.position.x += 15
				sprite.play("shootDeitado")
				await get_tree().create_timer(0.3).timeout
				sprite.position.x -= 15
				sprite.play("down")
			elif sprite.animation == "downLeft":
				sprite.position.x -= 15
				sprite.play("shootDownLeft")
				await get_tree().create_timer(0.3).timeout
				sprite.position.x += 15
				sprite.play("downLeft")
			elif sprite.animation == "left":
				sprite.play("shootLeft")
				await get_tree().create_timer(0.3).timeout
				sprite.play("left")

func animate_side():
	sprite.scale = Vector2(2, 2)
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
		
	else:
		sprite.stop()

		
func move_8way(delta):
	get_8way_input()
	animate()
	move_and_slide()
	
func move_side(delta):	
	velocity.y += gravity * delta
	get_side_input()
	animate_side()
	move_and_slide()
	#print(velocity * delta)

func _physics_process(delta):
	#move_8way()
	move_side(delta)
