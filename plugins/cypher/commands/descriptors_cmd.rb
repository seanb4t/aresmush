module AresMUSH
  module Cypher
    class DescriptorsCmd
      include CommandHandler

      attr_accessor :descriptor_name

      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_optional_arg2)
        self.descriptor_name = titlecase_arg(args.arg1)
      end

      def handle
        descriptors = Global.read_config('cypher', 'descriptors')
        if descriptor_name.nil?
          list = descriptors.sort_by { |s| s['name'].to_s }
          paginator = Paginator.paginate(list, cmd.page, 25)
          if paginator.out_of_bounds?
            client.emit_failure paginator.out_of_bounds_msg
          else
            template = DescriptorsListTemplate.new(paginator)
            client.emit template.render
          end
        else
          descriptor = descriptors.find { |d| d['name'] == descriptor_name }
          template = DescriptorTemplate.new(descriptor)
          client.emit(template.render)
        end
      end
    end
  end
end
