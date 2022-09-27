extends OptionButton

var devices: Array

func _ready() -> void:
	devices = AudioServer.capture_get_device_list()
	for i in range(devices.size()):
		var device = devices[i]
		add_item(device)
		if device == AudioServer.capture_get_device():
			select(i)

func _on_device_selection_item_selected(index: int) -> void:
	AudioServer.capture_set_device(devices[index])
