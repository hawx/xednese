class Esendex
  module Responses
    module Parser
      def self.for(&block)
        Class.new.tap {|klass|
          klass.singleton_class.send(:define_method, :parse) {|s| block.call(s) }
        }
      end
    end
  end
end
