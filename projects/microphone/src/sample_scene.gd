extends MarginContainer

onready var record_button = $ui/recording_controls/record_button
onready var recording_player = $recording_player
onready var save_edit = $ui/recording_controls/save_name
onready var play_button = $ui/recording_controls/play_button
onready var save_button = $ui/recording_controls/save_button
onready var mic_input = $mic_input

var record_bus_index: int
var record_effect: AudioEffectRecord
var recording: AudioStreamSample

func _ready() -> void:
	record_bus_index = AudioServer.get_bus_index('Record')
	# Only one effect on the bus, so can just assume index 0 for record effect
	record_effect = AudioServer.get_bus_effect(record_bus_index, 0)
	update_button_states()

func _on_record_button_pressed() -> void:
	if record_effect.is_recording_active():
		stop_recording()
	else:
		start_recording()
	update_button_states()

func _on_play_button_pressed() -> void:
	if !recording:
		return
	recording_player.stream = recording
	recording_player.play()

func _on_save_button_pressed() -> void:
	if !recording:
		return

	var save_name = 'my_recording'
	if save_edit.text:
		save_name = save_edit.text
	recording.save_to_wav('%s' % save_name)

func start_recording() -> void:
	record_effect.set_recording_active(true)
	record_button.text = 'Stop recording'

func stop_recording() -> void:
	record_effect.set_recording_active(false)
	record_button.text = 'Start recording'
	recording = record_effect.get_recording()

func update_button_states() -> void:
	play_button.disabled = !recording
	save_button.disabled = !recording

func _on_amp_spinbox_value_changed(value: float) -> void:
	mic_input.volume_db = linear2db(value)
