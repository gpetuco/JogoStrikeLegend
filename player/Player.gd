extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0

var target = position

func get_mouse_click():
	if Input.is_action_pressed("click"):
		target = get_global_mouse_position()
		
func get_mouse_input():
	look_at(get_global_mouse_position())
	#print(rotation_degrees)
	#print(transform)
	velocity = transform.x * Input.get_axis("down", "up") * speed

func get_rot_input():
	rotation_direction = Input.get_axis("left", "right")
	# transform.x corresponde à "frente" do objeto (gira quando mudar a rotação)
	velocity = transform.x * Input.get_axis("down", "up") * speed
	print(transform.x)
	
func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")	
	velocity = input_direction * speed
	#print(velocity)

func _physics_process(delta):
	#get_8way_input()   # 1. movimento 8-way
	#get_rot_input()     # 2. movimento rotação + desl.	
	#rotation += rotation_direction * rotation_speed * delta # 2. idem
	#get_mouse_input() # 3. gira com mouse + desl. setas
	# 4. click mouse + deslocamento automático
	get_mouse_click()
	var res := position.move_toward(target, 0.1)
	print(res)	
	velocity = position.direction_to(target) * speed
	#look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()
	#move_and_slide()
