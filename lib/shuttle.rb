require "shuttle/railtie"

module Shuttle
  def self.yaml
    begin
      YAML.load_file(Rails.root.join('config/shuttle.yml').to_s)
    rescue Errno::ENOENT
      nil
    end
  end

  def self.steps
    yaml['steps'] if yaml.present?
  end

  def self.stages
    yaml['stages'] if yaml.present?
  end
end
