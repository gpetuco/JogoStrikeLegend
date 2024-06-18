extends Node2D

@onready var player : CharacterBody2D = $Level/AnimPlayer
@onready var hud : CanvasLayer = $HUD
@onready var sceneLimit : Marker2D = $Level/SceneLimit

var gameScore : int = 0
var currentScene = null
var lowpass : AudioEffectLowPassFilter


func _ready() -> void:
	print("Jogo começou!")
	print("Pos:"+str(player.position))
	lowpass = AudioServer.get_bus_effect(1, 0) as AudioEffectLowPassFilter # Barramento 1 (Music), efeito 0 (Filtro passa-baixa)
	lowpass.cutoff_hz = 20000 # inicial, sem corte de freq.

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		player = $Level/AnimPlayer
		sceneLimit = $Level/SceneLimit		
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene_to_file("res://game_over.tscn")
	if player.position.x >= 1900:
		get_tree().change_scene_to_file("res://win.tscn")
	#if Input.is_action_just_pressed("change"):	# mapeada para "X"	
	#	call_deferred("goto_scene","res://levels/level2.tscn")

		
	# Tecla F liga/desliga o filtro passa-baixa
	if Input.is_action_just_pressed("lowpass"):
		if lowpass.cutoff_hz == 500:
			lowpass.cutoff_hz = 20000
		else:
			lowpass.cutoff_hz = 500
		
func updateScore():

	gameScore += 1

	hud.setScore(gameScore)
	

func _on_jumped():
	updateScore()
	
func goto_scene(path: String):
	print("Total children: "+str(get_child_count()))
	
	var res := ResourceLoader.load(path)
	currentScene = res.instantiate()
	
	var world := get_child(2)
	world.free()
	
	sceneLimit = null
	add_child(currentScene)
