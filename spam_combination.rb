require 'xmlsimple'
class SpamCombination

	attr_accessor :filePath
	attr_reader   :spamXML
	def initialize strFilePath
		@filePath = strFilePath
		@spamXML  = XmlSimple.xml_in(@filePath,{'KeyAttr'=>'name'})
	end
	
	def getCombination nameNum, mailNum, webNum, contentNum
		_contentNum = contentNum
		_nameNum = nameNum
		_mailNum = mailNum
		_webNum  = webNum
		result ={}
		#calculating the name
		size = @spamXML['username'].size
		index = _nameNum.abs % size 
		result['name'] = @spamXML['username'][index]

		#calculating the mail
		size = @spamXML['mail'].size
		index = _mailNum.abs % size 
		result['mail'] = @spamXML['mail'][index]

		#calculating the web
		size = @spamXML['web'].size
		index = _webNum.abs % size 
		result['web'] = @spamXML['web'][index]

		# calculating the content
		content = ''
		multiIndex = 1
		@spamXML['sense'].each do |aSense|
			multiIndex *= aSense['word'].size
		end
		@spamXML['sense'].each do |aSense|
			multiIndex /=  aSense['word'].size
			index = _contentNum / multiIndex 
            content += aSense['word'][index]
			_contentNum %= multiIndex
		end
		# end calculating the content
		result['content'] = content

		return result
	end

	def getCombinationByOneNumber totalNum
		nameSize = @spamXML['username'].size
		mailSize = @spamXML['mail'].size
		webSize  = @spamXML['web'].size
        wordSize = 1
		@spamXML['sense'].each do |aSense|
			wordSize *= aSense['word'].size
		end
		multiIndex = nameSize*mailSize*webSize*wordSize
		
		#calculating the name number
		multiIndex/= nameSize
		nameIndex = totalNum / multiIndex
		totalNum %= multiIndex
		#calculating the mail number
		multiIndex/= mailSize
		mailIndex = totalNum / multiIndex
		totalNum %= multiIndex
		#calculating the web number
		multiIndex/= webSize
		webIndex = totalNum / multiIndex
		totalNum %= multiIndex
		#calculating the content number
		contentIndex = totalNum	
		return getCombination nameIndex,mailIndex,webIndex,contentIndex
	end	

end
