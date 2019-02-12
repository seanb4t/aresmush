$LOAD_PATH.unshift File.dirname(__FILE__)

module AresMUSH
  module Cypher

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config('cypher', 'shortcuts')
    end

    def self.get_cmd_handler(client, cmd, enactor)
      Global.logger.debug("#{self.class.name}: #{client} Enactor=#{enactor} Cmd=#{cmd} CmdRoot=#{cmd.root}")
      case cmd.root
      when "descriptors"
        return DescriptorsCmd
      when "skills"
        return SkillsCmd
      end
    end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      nil
    end

  end
end
