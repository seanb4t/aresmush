module AresMUSH
  module Cypher
    class DescriptorsListTemplate < ErbTemplateRenderer
      attr_accessor :paginator

      def initialize(paginator)
        @paginator = paginator
        super File.dirname(__FILE__) + "/descriptors_list.erb"
      end
    end
  end
end
