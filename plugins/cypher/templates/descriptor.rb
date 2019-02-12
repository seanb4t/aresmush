module AresMUSH
  module Cypher
    class DescriptorTemplate < ErbTemplateRenderer
      attr_accessor :descriptor
      def initialize(descriptor)
        @descriptor = descriptor
        super File.dirname(__FILE__) + "/descriptor.erb"
      end
    end
  end
end
