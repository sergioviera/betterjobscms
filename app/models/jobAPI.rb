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

    if args[:a]
      params['City'] = args[:a]
    end

    if args[:t]
      params['JobTitle'] = args[:t]
    end

    if args[:i]
      params['CompanyName'] = args[:i]
    end

    if args[:d]
      params['PostedWithin'] = args[:d]
    end

    if args[:p]
      params['PageNumber'] = args[:p]
    end

    if args[:radius]
      params['Radius'] = args[:radius]
    end

    if args[:Category]
      params['Category'] = args[:Category]
    end

    if args[:cy]
      params['CountryCode'] = args[:cy]
    end

    get('/getJob', :query => params)
  end

end

