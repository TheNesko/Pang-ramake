extends Node


var Menu = preload("res://bin/Levels/Menu.tscn")
var TestLevel = preload("res://bin/Levels/TestScene.tscn")
var Level_1 = preload("res://bin/Levels/Level1.tscn")
var Level_2 = preload("res://bin/Levels/Level2.tscn")
var Level_3 = preload("res://bin/Levels/Level3.tscn")

var Levels = []

func _ready():
	Levels.append(TestLevel)
	Levels.append(Level_1)
	Levels.append(Level_2)
	Levels.append(Level_3)
