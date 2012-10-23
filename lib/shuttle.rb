require "shuttle/railtie"
require 'yaml'

module Shuttle
  def self.steps
    yml = YAML::load(File.open(Rails.root.join('config', 'shuttle.yml').to_s))
    yml['steps'] if yml.present?
  end
end
