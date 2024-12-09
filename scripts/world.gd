extends Node2D

# size will actually be this times 2, since this is only one side
const OUTER_LIMIT = 800

@onready var v_vel_lbl = $HUD/Control/v_vel
@onready var h_vel_lbl = $HUD/Control/h_vel
@onready var fuel_lbl = $HUD/Control/fuel
@onready var alt_lbl = $HUD/Control/altitude
@onready var tile_map = $TileMap
var loaded_chunks = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	handle_chunks()
	update_hud()


func update_hud():
	pass


func handle_chunks():
	var ship_pos = floor($Ship.position.x / tile_map.tile_set.tile_size.x)
	
	var left_limit = ship_pos - OUTER_LIMIT
	var right_limit = ship_pos + OUTER_LIMIT
	
	var valid_chunks = []
	for pos in range(left_limit, right_limit+1, tile_map.CHUNK_SIZE):
		var chunk_num = tile_map.get_chunk_num(pos)
		if chunk_num not in loaded_chunks:
			tile_map.load_chunk(chunk_num)
			loaded_chunks.append(chunk_num)
		valid_chunks.append(chunk_num)
	
	# this whole thing could be changed to just delete chunks that are less than
	# or greater than the chunks for the left and right limit. Butt, it's working
	# right now and I'm too lazy.
	loaded_chunks.sort()
	for chunk_num in loaded_chunks:
		if chunk_num not in valid_chunks:
			tile_map.unload_chunk(chunk_num)
			loaded_chunks.pop_at(loaded_chunks.bsearch(chunk_num))
