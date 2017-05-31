class Server < ApplicationRecord
	has_many :users, dependent: :destroy
	
	def dig
		system("touch tmp/tempfile")
    	wFile = File.open("tmp/tempfile", "w+")
     	wFile.puts self.domain
 		wFile.close
		temp_dig = %x('lib/dig.sh')
		self.host = temp_dig.chomp if self.host == ""
		self.save
		system("echo "" > tmp/tempfile")
	end
end
