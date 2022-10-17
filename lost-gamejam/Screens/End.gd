extends Control


onready var global = get_node("/root/Global")


func _ready():
	$AnimationPlayer.play("fade in")
	$Panel/Total.text = String(global.deaths)
	if global.speedrun:
		$Panel/Elapsed.visible = true
		$Panel/Time.visible = true
		$Panel/Time.text = global.str_elapsed
