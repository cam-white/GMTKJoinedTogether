extends Node

export(String) var article_content_file
var article_content

class Calculator:
	var day: int
	var agency: String
	
	var discord: int
	var money: int
	
	func get_discord():
		return discord
		
	func get_money():
		return money
		
	func add_title(index: int):
		var _discord = ArticleContent._get_discord(day, agency, "titles", index)
		var _money = ArticleContent._get_money(day, agency, "titles", index)
		
		discord += _discord
		agency += _money
		
	func add_content(index: int):
		var _discord = ArticleContent._get_discord(day, agency, "content", index)
		var _money = ArticleContent._get_money(day, agency, "content", index)
		
		discord += _discord
		agency += _money
		
	func add_image(index: int):
		var _discord = ArticleContent._get_discord(day, agency, "images", index)
		var _money = ArticleContent._get_money(day, agency, "images", index)
		
		discord += _discord
		agency += _money
		
	func add_caption(index: int):
		var _discord = ArticleContent._get_discord(day, agency, "captions", index)
		var _money = ArticleContent._get_money(day, agency, "captions", index)
		
		discord += _discord
		agency += _money
		
	func add_interview(index: int):
		var _discord = ArticleContent._get_discord(day, agency, "interviews", index)
		var _money = ArticleContent._get_money(day, agency, "interviews", index)
		
		discord += _discord
		agency += _money
		
	func add_study(index: int):
		var _discord = ArticleContent._get_discord(day, agency, "studies", index)
		var _money = ArticleContent._get_money(day, agency, "studies", index)
		
		discord += _discord
		agency += _money
	
	func _init(_day: int, _agency: String, _discord: int, _money: int):
		day = _day
		agency = _agency
		
		discord = _discord
		money = _money

func get_event(day: int) -> String:
	return article_content[day]["event"]

func get_agencies(day: int) -> String:
	var agencies = article_content[day]["agencies"]
	return agencies.keys()

func get_title_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "titles")

func get_content_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "content")
	
func get_image_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "images")

func get_caption_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "captions")

func get_interview_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "interviews")
	
func get_study_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "studies")

func _get_element_strings(day, agency, attribute) -> Array: 
	var agencies = article_content[day]["agencies"]
	var elements = agencies[agency][attribute]
	
	var element_strings = []
	
	for element in elements:
		element_strings.push_back(element["text"])
		
	return element_strings

func _get_element(day, agency, attribute, index):
	var agencies = article_content[day]["agencies"]
	var temp = agencies[agency]
	var elements = temp[attribute]
	return elements[index]

func _get_discord(day, agency, attribute, index):
	var element = _get_element(day, agency, attribute, index)
	return element["discord"]
	
func _get_money(day, agency, attribute, index):
	var element = _get_element(day, agency, attribute, index)
	return element["money"]

func _ready():
	var document = _load_file(article_content_file)
	var parsed = JSON.parse(document)
	
	if parsed.error != OK:
		_panic()
	
	article_content = parsed.result
	
	var result = get_title_strings(0, "name of the agency")
	print(result)

func _load_file(name):
	var file = File.new()
	file.open(name, File.READ)
	
	var content = file.get_as_text()
	file.close()
	
	return content

func _panic():
	get_tree().quit()
