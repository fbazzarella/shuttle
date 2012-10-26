require "shuttle/railtie"

module Shuttle
  mattr_accessor :steps

  def self.setup
    yield self
  end
end
