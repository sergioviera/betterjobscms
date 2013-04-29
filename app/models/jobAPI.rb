require 'rubygems'
require 'httparty'


class JobAPI

  include HTTParty

#  format :xml

  base_uri 'http://www.betterjobs.com/api/1' #'7e389902-c671-4248-b234-728021e753b4'
#  base_uri 'http://dev.betterjobs.com:7777/OrionWeb/api/1' #/getJob?DeveloperKey=3a8b4813-2447-4d7b-a3c3-c30f66bac033&Keyword=java
#  base_uri 'http://200.124.110.12:7777/OrionWeb/api/1'

#http://www.betterjobs.com/api/1/getJob?DeveloperKey=7e389902-c671-4248-b234-728021e753b4&Keywords=java


  def self.get_jobs(args)
    params = {'DeveloperKey' => '7e389902-c671-4248-b234-728021e753b4',
#    params = {'DeveloperKey' => '3a8b4813-2447-4d7b-a3c3-c30f66bac033',
      'Keywords' => 'tennis',
#      'Location' => l,
      'CountryCode' => 'US'}
puts 'tennis'
    if !params[:k].nil?
      if !params[:k].empty?
        params.add( 'Keywords', params[:k] )
      end
    end

    if !params[:l].nil?
      if !params[:l].empty?
        params.add( 'Location', params[:l] )
      end
    end

#    puts get("http://www.betterjobs.com/api/1/getJob?DeveloperKey=7e389902-c671-4248-b234-728021e753b4&Keywords=ford&City=Dublin").inspect
#    puts get("http://whoismyrepresentative.com/whoismyrep.php?zip=46544").inspect
#    puts get('/getJob', :query => params).inspect

#    @doc=Nokogiri::XML(open('http://www.betterjobs.com/api/1/getJob?DeveloperKey=7e389902-c671-4248-b234-728021e753b4&Keywords=java'),nil,"ISO-8859-1")

    get('/getJob', :query => params)
  end

end

