extends Control



func _on_start_pressed():
	#Global.SceneChanger.change_scene("res://Scenes/World/Test_world/TestSecene.tscn")
	print("Start Game")


func _on_options_pressed():
	Global.SceneChanger.change_scene("res://Scenes/UI/Main_Menu/Options.tscn")


func _on_credits_pressed():
	print("Creditos")


func _on_exit_pressed():
	get_tree().quit()
