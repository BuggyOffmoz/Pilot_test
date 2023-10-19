extends WorldBaseObject

# EXPORTS-----------------------------------------------------------------------


# CONSTANTS---------------------------------------------------------------------


# BOOLEANS----------------------------------------------------------------------
var full = false

# INTEGERS ---------------------------------------------------------------------
@export var sheep_required: int = 0
@export_enum("White","Black") var specific_sheep_required: String
var actual_sheeps_in: int = 0

# ARRAYS------------------------------------------------------------------------


# VECTORS ----------------------------------------------------------------------



# FUNCTIONS---------------------------------------------------------------------

func _ready():
	update_visual_number()
	update_specifications()


func try_put_sheep():
	if full:
		pass
	else:
		if array_sheeps_detected.is_empty():
			pass
		else:
			var sheep_selected = array_sheeps_detected.pick_random()
			if sheep_selected.type_of_sheep == specific_sheep_required:
				array_sheeps_detected.remove_at(array_sheeps_detected.find(sheep_selected))
				sheep_selected.queue_free()
				actual_sheeps_in += 1
				verify_amount_sheeps_in()
			else:
				pass
		


func verify_amount_sheeps_in():
	if actual_sheeps_in == sheep_required:
		full = true
	update_visual_number()


func update_visual_number():
	$SpriteManager/SheepReq.text = str(sheep_required - actual_sheeps_in)

func update_specifications():
	$SpriteManager/Specific.text = specific_sheep_required
# SIGNALS-----------------------------------------------------------------------


func _on_timer_timeout():
	try_put_sheep()
