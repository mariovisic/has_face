module HasFace
  class Configuration

    @enable_validation = true

    class << self
      attr_accessor :enable_validation
      attr_accessor :hostname
    end

  end
end
