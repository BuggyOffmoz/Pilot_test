extends CanvasLayer

@onready var screen = $ColorRect

var tween : Tween

func change_scene(path : String, fadeOut := 0.5, fadeIn := 0.5):
	
	tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(screen, "color:a", 1.0, fadeOut)
	
	await tween.finished
	
	get_tree().change_scene_to_file(path)
	
	tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(screen, "color:a", 0.0, fadeIn)
