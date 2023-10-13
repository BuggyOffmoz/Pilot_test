extends Control

@onready var musicValue = $CenterContainer/GridContainer/MusicValue
@onready var musicSlider = $CenterContainer/GridContainer/MusicSlider
@onready var SFXValue = $CenterContainer/GridContainer/SFXValue
@onready var SFXSlider = $CenterContainer/GridContainer/SFXSlider

var button_pressed = false

func _ready():
	musicValue.text = "% " + str(Global.settings.MusicValue)
	musicSlider.value = Global.settings.MusicValue
	SFXValue.text = "% " + str(Global.settings.SFXValue)
	SFXSlider.value = Global.settings.SFXValue


func _on_music_slider_value_changed(value):
	var volumen_log = log(value + 1)
	var min_db = -36
	var max_db = 0
	var db = lerp(min_db, max_db, volumen_log / log(101))
	AudioServer.set_bus_volume_db(1, db)
	musicValue.text = "% " + str(value)
	
	Global.settings.MusicValue = value


func _on_sfx_slider_value_changed(value):
	var volumen_log = log(value + 1)
	var min_db = -36
	var max_db = 0
	var db = lerp(min_db, max_db, volumen_log / log(101))
	AudioServer.set_bus_volume_db(2, db)
	SFXValue.text = "% " + str(value)
	
	Global.settings.SFXValue = value


func _on_back_pressed():
	if !button_pressed:
		button_pressed = true
		Global.SceneChanger.change_scene("res://Scenes/UI/Main_Menu/Main_menu.tscn")
