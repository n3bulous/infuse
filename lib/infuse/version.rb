module Infuse
  module Version

    MAJOR = 0
    MINOR = 9
    TINY  = 5

    def self.to_s # :nodoc:
      [MAJOR, MINOR, TINY].join('.')
    end

  end
end
