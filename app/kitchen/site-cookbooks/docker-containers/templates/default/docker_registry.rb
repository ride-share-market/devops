require "net/http"
require "json"

class DockerRegistry
  def initialize(options = {})
    @host = options[:registry_host] || "192.168.33.10"
    @port = options[:registry_port] || 5000
  end

  def get_image_current_version(image_name)
    uri = URI("http://#{@host}:#{@port}/v1/repositories/#{image_name}/tags")
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body).keys.sort {|a,b| Gem::Version.new(a) <=> Gem::Version.new(b)}.pop
  end

end
