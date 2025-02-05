extends Control

var sentence = "Seorang penjelajah muda, Alex, dikenal karena keberanian dan rasa ingin tahunya yang besar. Suatu hari, ia memutuskan untuk menjelajahi hutan terpencil yang dikelilingi mitos tentang Entitas Hitam yang menghuni tempat itu. Saat menjelajahi bagian terdalam hutan, ia menemukan sebuah altar kuno yang penuh ukiran misterius. Ketika Alex menyentuh salah satu simbol, suara gemuruh terdengar, dan bayangan hitam besar mulai mengejarnya."
var sentences = []  # Untuk memecah teks menjadi bagian-bagian
var current_sentence_index = 0  # Indeks kalimat saat ini
var sen_index = 0  # Indeks karakter dalam kalimat
var is_waiting_for_next = false

func _ready() -> void:
	# Memecah paragraf menjadi kalimat-kalimat berdasarkan titik
	sentences = sentence.split(". ")
	# Tambahkan titik kembali ke setiap kalimat kecuali yang terakhir
	for i in range(sentences.size() - 1):
		sentences[i] += "."
	# Sembunyikan tombol-tombol awal
	$Panel/Button.visible = false
	$Button.visible = false

func _on_timer_timeout() -> void:
	if sen_index < sentences[current_sentence_index].length() and not is_waiting_for_next:
		# Tambahkan karakter ke RichTextLabel
		var char = sentences[current_sentence_index][sen_index]
		$Panel/RichTextLabel.append_text(char)
		sen_index += 1
		
		if char == ".":
			is_waiting_for_next = true
			$Panel/Button.visible = true  # Tampilkan tombol Next
	elif sen_index >= sentences[current_sentence_index].length():
		# Selesai menampilkan kalimat
		is_waiting_for_next = true
		$Panel/Button.visible = true

func _on_button_pressed() -> void:
	if current_sentence_index < sentences.size() - 1:
		# Pindah ke kalimat berikutnya
		current_sentence_index += 1
		sen_index = 0
		is_waiting_for_next = false
		$Panel/Button.visible = false
		$Panel/RichTextLabel.append_text("\n")  # Tambahkan baris baru
	else:
		# Jika kalimat terakhir, tampilkan tombol SceneChange
		$Panel/Button.visible = false
		$Button.visible = true
		get_tree().change_scene_to_file("res://scene/cobaa_2.tscn")
