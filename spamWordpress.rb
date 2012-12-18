require 'rubygems'
require 'selenium-webdriver'
require_relative 'spam_combination'

_spamCom = SpamCombination.new "spam_dictionary.xml"
_size = _spamCom.getCombinationSize
_sites = ["http://23.21.219.198/?p=1"]
driver = Selenium::WebDriver.for :firefox
_sites.each do |aSite|
	driver.get aSite 
	# get a random combination from the spam dictionary
    _index = rand(_size)
    _aCombination = _spamCom.getCombinationByOneNumber(_index)
	element = driver.find_element :name => "author"
	element.send_keys _aCombination["name"]
	element = driver.find_element :name => "email"
	element.send_keys _aCombination["mail"]
	element = driver.find_element :name => "url"
	element.send_keys _aCombination["web"]
	element = driver.find_element :name => "comment"
	element.send_keys _aCombination["content"]
	element = driver.find_element :name => "submit"
	element.submit
end 
driver.quit