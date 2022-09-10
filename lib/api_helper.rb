require "net/http"
require "json" 


class ApiHelper
    def initialize
	puts "Initiating Service URL"
	url="https://www.ebi.ac.uk/ols/api"
	@url=url
    end

    def http_error_handling(response)
	case response
	  when Net::HTTPFound then
	    puts "Exception: Empty Ontology ID"
	  when Net::HTTPNotFound then
	    puts "Exception: Invalid Address,Source Not Found."
	  when Net::HTTPMovedPermanently then
	    puts "Exception: Service Has Been Moved Permanently"
	  when Net::HTTPForbidden then
	    puts "Exception: Access To Resource Is Forbidden"
	  when Net::HTTPMethodNotAllowed then
	    puts "Exception: Method Not Allowed"
	  when Net::HTTPRequestTimeOut then
	    puts "Exception: Request TimeOut"
	  when Net::HTTPInternalServerError then
	    puts "Exception: Internal Server Error"
	  when Net::HTTPBadGateway then
	    puts "Exception: Bad Gateway"
	  when Net::HTTPServiceUnavailable then
	    puts "Exception: Service Unavailable"
	  when Net::HTTPGatewayTimeOut then
	    puts "Exception: Gateway TimeOut"
	  when Net::HTTPInsufficientStorage then
	    puts "Exception: Insufficient Storage"
	  else
	    puts "Exception has Occured, Response Code: #{response}"
	  end
    end

    def get_ontologies_id()
	puts "Fetching all ontology ids"
	url= "#{@url}/ontologies?page=0&size=277"
	puts "URL: #{url}"
	uri = URI(url)
	response=Net::HTTP.get_response(uri)

	case response
	    when Net::HTTPSuccess then
		jresp=JSON.parse(response.body)
	    	jresp["_embedded"]["ontologies"].each_with_index do |ont,index|
			title = ont["config"]["title"] ? ont["config"]["title"] : "<no title>"
			puts (index+1).to_s << ". "<< ont["ontologyId"] << " : " << title.to_s 
		end
	    else
		puts "An Error Has Occured!"
		http_error_handling(response)
	    end
    end
 

    def get_ontologies_full()
	puts "Fetching ontologies with full details"
	url=url= "#{@url}/ontologies?page=0&size=277"
	puts "URL: #{url}"
	uri = URI(url)
	response=Net::HTTP.get_response(uri)

	case response
	    when Net::HTTPSuccess then
		puts "Success!"
		JSON.parse(response.body)
	    else
		puts "An Error Has Occured!"
		http_error_handling(response)
	    end
    end

    def get_ontology_by_id(ontology_id)  
	puts "Fetching single ontology details"
	puts "Input ID: " << ontology_id.to_s
	ont_url=url= "#{@url}/ontologies/#{ontology_id.strip.to_s}"
	puts "URL: #{ont_url}"		
	uri = URI(ont_url)
	response=Net::HTTP.get_response(uri)
	case response
	    when Net::HTTPSuccess then
		puts "Success!"
		jresp=JSON.parse(response.body)
		puts "ID: #{jresp['ontologyId']}"
		puts "Title: #{jresp['config']['title']}"
		puts "Descrption: #{jresp['config']['description']}"
		puts "Number of Terms: #{jresp['numberOfTerms']}"
		puts "Current Status: #{jresp['status']}"
	    else
	    	case response 
	    	    when Net::HTTPNotFound
	    	        puts "Invalid Id, Ontology Not Found"
	    	else
		    http_error_handling(response)
	    	end
	    end
    end
end