extends VBoxContainer

onready var samples_spinbox = $controls/samples_control/samples_spinbox
onready var amp_spinbox = $controls/amplification_control/amp_spinbox
onready var volume_bar = $monitors/volume_monitor/volume_bar
onready var volume_value = $monitors/volume_monitor/volume_value
onready var bars = $monitors/frequency_monitor/bars

const MIN_DB: int = 80

var record_live_index: int
var volume_samples: Array = []
var frequency_samples: Dictionary = {}
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance

func _ready() -> void:
	record_live_index = AudioServer.get_bus_index('Record')
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_live_index, 1)
	init_spectrum_samples()

func init_spectrum_samples() -> void:
	for child in bars.get_children():
		var frequency = int(child.name)
		frequency_samples[frequency] = []

func _process(delta: float) -> void:
	update_samples_strength()
	update_samples_frequency()

func update_samples_frequency() -> void:
	var prev_frequency = 0
	for i in bars.get_child_count():
		var bar = bars.get_children()[i]
		var frequency = int(bar.name)
		var magnitude = spectrum_analyzer.get_magnitude_for_frequency_range(
			prev_frequency,
			frequency,
			AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE
		).length()

		# Boost the signal and normalize it
		var energy = clamp((MIN_DB + linear2db(magnitude))/MIN_DB * amp_spinbox.value, 0, 1)
		frequency_samples[frequency].push_front(energy)

		while frequency_samples[frequency].size() > samples_spinbox.value:
			frequency_samples[frequency].pop_back()

		bar.get_node('bar').modulate = Color('#3D312E').linear_interpolate(Color('#F0EBDA'), average_array(frequency_samples[frequency]))

		prev_frequency = frequency

func update_samples_strength() -> void:
	var sample = db2linear(AudioServer.get_bus_peak_volume_left_db(record_live_index, 0))
	# Amplify the signal if it's too weak
	sample = clamp(sample * amp_spinbox.value, 0, 1)
	volume_samples.push_front(sample)

	# Use a while loop that way the user can adjust the number of samples at runtime
	# and remove as many as needed when the value changes
	while volume_samples.size() > samples_spinbox.value:
		volume_samples.pop_back()

	var sample_avg = average_array(volume_samples)
	volume_value.text = '%sdb' % round(linear2db(sample_avg))
	volume_bar.value = sample_avg

func average_array(arr: Array) -> float:
	var avg = 0.0
	for i in range(arr.size()):
		avg += arr[i]
	avg /= arr.size()
	return avg
