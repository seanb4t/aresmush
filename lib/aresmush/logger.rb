require 'fileutils'

module AresMUSH
  class AresLogger
    include FileUtils
    def start
      config = Global.config['logger']
      configurator = Log4r::YamlConfigurator
      mkdir_p config['log_dir']
      configurator['log_dir'] = config['log_dir']
      configurator.decode_yaml config
    end
    
    def self.logger
      logger = Log4r::Logger['ares']
      # For tests - use a dummy logger if one's not there already
      logger = Log4r::Logger.root if logger.nil?
      logger
    end
  end
end
