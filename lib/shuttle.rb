require "shuttle/railtie"

module Shuttle
  mattr_accessor :steps, :stages

  def self.setup
    yield self
  end
end
