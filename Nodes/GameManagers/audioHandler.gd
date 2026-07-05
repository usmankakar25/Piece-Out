extends Node2D

@onready var sfxPlayer := AudioStreamPlayer.new()
@onready var musicPlayer := AudioStreamPlayer.new()
@onready var musicController = $AnimationPlayer

const fadeTime: float = 1.0
const minimumVolume: float = -80.0
const baseVolume = -5

var loopMusic = false

func _ready():
	add_child(sfxPlayer)
	add_child(musicPlayer)
	musicPlayer.finished.connect(restartMusic)

func playSfx(stream: AudioStream):
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.bus = "SFX"
	player.volume_db = baseVolume
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

func playMusic(stream: AudioStream, loop = true):
	loopMusic = loop
	if musicPlayer.stream == stream and musicPlayer.playing:
		return
	musicPlayer.volume_db = baseVolume
	musicPlayer.stream = stream
	musicPlayer.play()
	
func restartMusic():
	if loopMusic:
		musicPlayer.play()
	
func fadeMusic():
	var tween := get_tree().create_tween()
	tween.tween_property(musicPlayer,"volume_db",minimumVolume,fadeTime).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(musicPlayer.stop)
