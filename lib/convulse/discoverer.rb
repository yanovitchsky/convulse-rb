module Convulse
  class Discoverer
    BASE_URL = "#{Convulse.configuration.consul_uri}/v1/catalog/service/"

    def fetch_service(service)
      service_name = is_a?(String) ? service : service.to_s
      begin
        get_from_cache(service) || query_consul(service_name)
      rescue Exception => e
        e
      end
    end

    private

    def query_consul(service)
      url = "#{BASE_URL}#{service}"
      res = HTTParty.get(url)
      case res.code
      when 200
        res = handle_200(res.parsed_response)
        unless res == [:error, :unknown_service]
          cache = Cache.instance
          cache[service] = res
        end
        res
      when 404
        handle_404()
      else
        handle_error(res.parsed_response)
      end
    end

    def get_from_cache(service)
      cache = Cache.instance
      cache[service]
    end

    def handle_200(response)
      if response.size > 0
        services = response.map do |res|
          {
            service_name: res['ServiceName'],
            address: res['ServiceAddress'],
            port: res['ServicePort']
          }
        end
        [:ok, services]
      else
        [:error, :unknown_service]
      end
    end

    def handle_404
      [:error, :not_found]
    end

    def handle_error(response)
      [:error, response.body]
    end
  end
end
