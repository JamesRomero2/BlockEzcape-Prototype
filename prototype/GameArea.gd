extends Node2D

onready var puzzleNode = $PuzzlePhase
onready var scrollNode = $ScrollPhase

func _on_Door_PuzzlePhaseComplete():
	puzzleNode.visible = false
	scrollNode.visible = true
