extends MarginContainer

@onready var value_label = $contents/getter/value
@onready var count_label = $contents/getter/count
@onready var update_label = $contents/update_label

var read_count: int = 0
var value: String = '':
	set(new_value):
		value = new_value
		update_label.text = 'Valued updated to "%s"' % new_value
	get:
		read_count += 1
		return value

func _on_read_pressed() -> void:
	value_label.text = 'Value: "%s"' % value
	count_label.text = 'Reads: %s' % read_count

func _on_input_text_changed(new_value: String) -> void:
	value = new_value
