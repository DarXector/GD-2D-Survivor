extends AudioStreamPlayer2D


@export var streams: Array[AudioStream] = []


func play_random():
	if streams.size() == 0:
		return

	stream = streams.pick_random()
	play()
