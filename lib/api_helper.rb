require "http"
require "json" 

class ApiHelper
	
	def initialize
		puts "Initiating Service URL"
		url="http://www.ebi.ac.uk/ols/api"
		@url=url
	end

	def get_ontologies_id()
		puts "Fetching all ontology ids"
		url=@url << "/ontologies?page=0&size=277"
		puts "URL: #{url}"
		response=HTTParty.get(url)
		if response.code == 200
			jresp=JSON.parse(response.body)
			jresp["_embedded"]["ontologies"].each_with_index do |ont,index|
				title = ont["config"]["title"] ? ont["config"]["title"] : "<no title>"
				puts (index+1).to_s << ". "<< ont["ontologyId"] << " : " << title.to_s 
			end
                elsif response.code == 503
                        puts "503 Service Unavailable, Please try again later."
                else
                        puts "Some Exception has occured."
		end
	end

	def get_ontologies_full()
		puts "Fetching ontologies with full details"
		url=@url << "/ontologies?page=0&size=277"
		puts "URL: #{url}"
		response=HTTParty.get(@@url)
		if response.code == 200
			puts response.body
		elsif response.code == 503
                        puts "503 Service Unavailable, Please try again later."
                else
                        puts "Some Exception has occured."
		end
	end

	def get_ontology_by_id(ontology_id)  
		puts "Fetching single ontology details"
		puts "Input ID: " << ontology_id.to_s
		ont_url=@url << "/ontologies/" << ontology_id.strip.to_s
		puts "URL: #{ont_url}"
		response=HTTParty.get(ont_url)
		puts "Response Code: #{response.code}"
		if response.code == 200
			jresp=JSON.parse(response.body)
			puts "ID: #{jresp['ontologyId']}"
			puts "Title: #{jresp['config']['title']}"
			puts "Descrption: #{jresp['config']['description']}"
			puts "Number of Terms: #{jresp['numberOfTerms']}"
			puts "Current Status: #{jresp['status']}"
			# puts response.body
		elsif response.code == 503
			puts "503 Service Unavailable, Please try again later."
		elsif response.code == 404
			puts "404 Invalid Id, Ontology not found."
		else
			puts "Some Exception has occured."
		end
	end
end



# helper=ApiHelper.new
# helper.get_ontologies_id 
# helper.get_ontologies_full
# helper.get_ontology_by_id("zfa")

