extends TileMapLayer

const CHUNK_SIZE = 100


func get_chunk_num(x):
	return floor(x / 100)


func load_chunk(chunk_num):
	var left_limit = chunk_num * CHUNK_SIZE
	var right_limit = chunk_num * CHUNK_SIZE + CHUNK_SIZE
	
	for x in range(left_limit, right_limit):
		set_cell(Vector2(x, 0), 1, Vector2(11, 2), 0)


func unload_chunk(chunk_num):
	var left_limit = chunk_num * CHUNK_SIZE
	var right_limit = chunk_num * CHUNK_SIZE + CHUNK_SIZE
	
	for x in range(left_limit, right_limit):
		set_cell(Vector2(x, 0), -1, Vector2(11, 2), 0)
