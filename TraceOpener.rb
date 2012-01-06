require 'pp' 



class TraceOpener

	attr_accessor :traceFile, :vimScriptFile, :traceType 

	#:return: => Object
	#:arg: traceFile => Object
	#:arg: vimScriptFile => Object
	#:arg: traceType => Object
	def initialize( traceFile, vimScriptFile, traceType ) 
		@traceFile = traceFile 
		@vimSimpleFile = vimSimpleFile 
		@traceType = traceType 
	end 

	#:return: => Object
	def createVimScript()
    	
	    traceFileHandle = open( @traceFile,"r" )

		fileArray = []  
		if( @traceType == "python" )
			fileArray =  pythonTrace( traceFileHandle ) 				
		end
	
		vimScriptFileHandle = open( @vimScriptFile,  "w" )
		vimScriptFileHandle.close()
    	
	end

	#:return: => Object
	#:arg: fileArray => Object
	#:arg: vimScriptFileHandle => Object#		
	def fileArrayToVim(fileArray, vimScriptFileHandle)
		fileArray.each { |fileData| 	
			
		 vimScriptFileHandle.puts("view " + fileData.fileName ) 
		 vimScriptFileHandle.puts("set nu")
		 vimScriptFileHandle.puts("execute \"normal #{fileData.lineNumber}G\"")
		 vimScriptFileHandle.puts("split") 
		}
	end

	def rubyTrace( traceFileData ) 
	end

	def javaTrace( traceFileData ) 
	end 
	
	#:return: => Object
	#:arg: traceFileData => Object
	def pythonTrace( traceFileData ) 

		traceArray = [] 
	
		traceFileData.each { |line|
			fileName = ""
			lineNum = "" 
			line.strip!
		
			m =  /File "(.+)", line (\d+),/.match(line) 	
			if m != nil
			  traceArray.insert(0, FileData.new(m[1], m[2]))
			end
		}
		
		return traceArray
	end 
end # END TraceOpener 


=begin 
Example usage 


 traceOpener = TraceOpener.new(ARGV[0], ARGV[1], "python") 
 traceOpener.createVimScript() 

=end 
