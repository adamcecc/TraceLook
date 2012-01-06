
class FileData
    attr_accessor :fileName, :lineNumber   	
		
	def initialize( fileName, lineNumber )
		@fileName = fileName
		@lineNumber = lineNumber
	end
	
	def to_s()
		return "File: " + fileName + " Line: " + lineNumber
	end
end
