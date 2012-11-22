require 'yaml'
require 'date'
require 'json'
require 'rest-client'

Puppet::Reports.register_report(:cube) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "cube.yaml"])
  raise(Puppet::ParseError, "Cube report config file #{configfile} not readable") unless File.exist?(configfile)
  CONFIG = YAML.load_file(configfile)

  desc <<-DESC
  Send Puppet log events to Cube.
  DESC

  def process
    request = RestClient::Resource.new("http://#{CONFIG[:host]}:#{CONFIG[:port]}")
    endpoint_path = '/1.0/event/put'
    type = "puppet_log"

    self.logs.each do |log|
      event = [{
        :type => type,
        :time => DateTime.now,
        :data => { :host => self.host, :output => log },
      }]
      request[endpoint_path].post event.to_json
    end
  end
end
