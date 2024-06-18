extends Node2D

const SPEED : int = 100
var total : float = 0

func _input(event: InputEvent) -> void:
	#print(event.as_text())
	if event.is_action_pressed("ui_up"):
		print("Up arrow!")
		#position.x += 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(total)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(delta)
	total += delta
	update_score(total)
	if Input.is_action_pressed("ui_left"):
		position.x -= SPEED * delta # pixels/seg
	elif Input.is_action_pressed("ui_right"):
		position.x += SPEED * delta # pixels/seg

func update_score(current_score: float) -> void:
	#get_node("Score").text = str(current_score) # converte para string
	$Score.text = "A - move para esquerda\n D - move para direita \nW - mira para cima \nS - se abaixa \nR - recarrega \nClique do mouse - Atira"
	
