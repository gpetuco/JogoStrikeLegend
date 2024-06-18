extends CanvasLayer

@onready var scoreLabel : Label = $C

# Responsabilidade de atualizar o TEXTO
# do score na tela é do HUD!

func _ready() -> void:
	setScore(0)
	
func updateScore():
	print("updateScore do HUD!")
	
func setScore(score: int):
	scoreLabel.text = "A - move para esquerda\n D - move para direita \nW - mira para cima \nS - se abaixa \nR - recarrega \nClique do mouse - Atira"
