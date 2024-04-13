extends Node2D

@export var menuScene: PackedScene
@export var homeScene: PackedScene
@export var drivingScene: PackedScene
@export var officeScene: PackedScene

var stateScene = load("res://state_container.tscn")
var state

var current_scene = ""
var scene

var scene_class_map
var next_scene_map = {
		"": "menu",
		"menu": "home",
		"home": "driving_to",
		"driving_to": "office",
		"office": "driving_from",
		"driving_from": "home",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_class_map = {
		"menu": menuScene,
		"home": homeScene,
		"driving_to": drivingScene,
		"office": officeScene,
		"driving_from": drivingScene,
	}
	state = stateScene.instantiate()
	next_scene()

func _on_scene_finished():
	scene.queue_free()
	next_scene()

func next_scene():
	current_scene = next_scene_map[current_scene]
	print("LOADING SCENE", current_scene)
	var scene_class = scene_class_map[current_scene]
	print("SCENE_CLASS", scene_class)
	scene = scene_class.instantiate()

	print("GOT STATE", state)
	if scene.has_method("init"):
		scene.init(state)
	scene.position = Vector2(0, 0)
	scene.finished.connect(_on_scene_finished)
	add_child(scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
