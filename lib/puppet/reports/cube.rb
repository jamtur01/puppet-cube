require 'yaml'
require 'cube'
require 'date'

Puppet::Reports.register_report(:cube) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "cube.yaml"])
  raise(Puppet::ParseError, "Cube report config file #{configfile} not readable") unless File.exist?(configfile)
  CONFIG = YAML.load_file(configfile)

  desc <<-DESC
  Send Puppet log events to Cube.
  DESC

  def process
    $cube = Cube::Client.new CONFIG[:host], CONFIG[:port]
    type = "puppet_log"
    self.logs.each do |log|
      time = DateTime.now
      data = { host: self.host, output: log }
      $cube.send type, time, data
    end
  end
end
