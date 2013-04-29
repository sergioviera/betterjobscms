require 'rubygems'
require 'httparty'

class JobAPI
  include HTTParty

  base_uri 'http://www.betterjobs.com/api/1'

  def self.get_jobs(args)
    # initialize default values
    params = {'DeveloperKey' => '7e389902-c671-4248-b234-728021e753b4',
      'PerPage' => 10,
      'usefacets' => true,
      'CountryCode' => 'US'}

    if args[:k]
      params['Keywords'] = args[:k]
    end

    if args[:l]
      params['Location'] = args[:l]
    end

    if args[:Category]
      params['Category'] = args[:Category]
    end

    if args[:page]
      params['PageNumber'] = args[:page]
    end

    get('/getJob', :query => params)
  end

end

