require 'xmlsimple'
config = XmlSimple.xml_in('spam_dictionary.xml',{'KeyAttr'=>'name'})
puts config['logdir']
