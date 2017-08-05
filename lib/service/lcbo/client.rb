require 'open-uri'

module Service::Lcbo
  class Client

    USER_AGENT = 'LCBOShopper/1.0'

    DEFAULT_PER_PAGE = 25
    DEFAULT_WHERE_NOT = 'is_dead,is_discontinued'
    DEFAULT_HEADERS = {
        'User-Agent' => USER_AGENT,
        'Authorization' => "Token #{LCBO_KEY}",
    }

    def product(id)
      url = "#{LCBO_URL}/products/#{id}"
      request = Typhoeus::Request.new(
          url,
          method: :get,
          headers: DEFAULT_HEADERS,
      )
      response = request.run
      response = JSON.parse(response.body)['result']
      if response.nil?
        # happens when we get a bogus ID
        nil
      else
        response.symbolize_keys
      end
    end

    def search(query, per_page = DEFAULT_PER_PAGE, page = 0)
      if query
        url = construct_url(query, per_page, page)
        request = Typhoeus::Request.new(url, method: :get,
                                        headers: DEFAULT_HEADERS)
        response = request.run
        response = JSON.parse(response.body)['result']
        if response.nil?
          nil
        else
          response.map {|h| h.symbolize_keys}
        end
      else
        []
      end
    end

    private

    def construct_url(query, per_page = DEFAULT_PER_PAGE, page = 0)
      url = "#{LCBO_URL}/products?q=#{URI::encode(query)}&where_not=#{DEFAULT_WHERE_NOT}&per_page=#{per_page}"
      url += "&page=#{page}" if page != 0
      url
    end
  end
end