extends HSlider

@export var audio_bus_name = "Master"

@onready var _bus_index = AudioServer.get_bus_index(audio_bus_name)

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus_index))


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus_index, linear_to_db(value))


func _on_drag_started() -> void:
	$TestSound.play()


func _on_drag_ended(_value_changed: bool) -> void:
	$TestSound.stop()
