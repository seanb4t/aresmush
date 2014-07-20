module AresMUSH
  def self.game_path
    File.expand_path(File.join(File.dirname(__FILE__), "..", "game"))
  end
  
  def self.version
    File.read(File.join(game_path, "version.txt"))
  end
end

# Require this before all other items
require 'bundler/setup'

require 'ansi'
require 'yaml'
require 'eventmachine'
require 'mongo'
require 'i18n'
require "i18n/backend/fallbacks" 
require 'erubis'
require 'log4r'
require 'log4r/yamlconfigurator'
include Log4r
require 'date'
require 'bcrypt'
require 'rake'
require 'rspec/core/rake_task'
require 'mongoid'
require 'pp'
#require 'json'

require 'aresmush/bootstrapper'
require 'aresmush/client/client_monitor'
require 'aresmush/client/client.rb'
require 'aresmush/client/client_factory.rb'
require 'aresmush/client/client_greeter.rb'
require 'aresmush/commands/arg_cracker.rb'
require 'aresmush/commands/command'
require 'aresmush/commands/command_alias_parser'
require 'aresmush/commands/command_cracker.rb'
require 'aresmush/commands/common_cracks.rb'
require 'aresmush/commands/dispatcher.rb'
require 'aresmush/commands/global_events.rb'
require 'aresmush/command_line'
require 'aresmush/config/config_reader'
require 'aresmush/connection.rb'
require 'aresmush/core_ext/module_ext.rb'
require 'aresmush/core_ext/string_ext.rb'
require 'aresmush/core_ext/yaml_ext.rb'
require 'aresmush/core_ext/hash_ext.rb'
require 'aresmush/core_ext/match_data_ext.rb'
require 'aresmush/database.rb'
require 'aresmush/formatters/ansi_formatter.rb'
require 'aresmush/formatters/client_formatter.rb'
require 'aresmush/formatters/time_formatter.rb'
require 'aresmush/formatters/line.rb'
require 'aresmush/formatters/pose_formatter.rb'
require 'aresmush/formatters/random_colorizer.rb'
require 'aresmush/formatters/substitution_formatter.rb'
require 'aresmush/formatters/bordered_display.rb'
require 'aresmush/global.rb'
require 'aresmush/hash_reader.rb'
require 'aresmush/locale/locale.rb'
require 'aresmush/locale/locale_loader.rb'
require 'aresmush/logger.rb'
require 'aresmush/models/object_model.rb'
require 'aresmush/models/character.rb'
require 'aresmush/models/room.rb'
require 'aresmush/models/exit.rb'
require 'aresmush/models/game.rb'
require 'aresmush/models/supporting_object_model.rb'
require 'aresmush/plugin/plugin_manager.rb'
require 'aresmush/plugin/plugin_factory.rb'
require 'aresmush/plugin/plugin.rb'
require 'aresmush/plugin/plugin_validators.rb'
require 'aresmush/plugin_helpers/find_result.rb'
require 'aresmush/plugin_helpers/single_result_selector.rb'
require 'aresmush/plugin_helpers/class_target_finder.rb'
require 'aresmush/plugin_helpers/any_target_finder.rb'
require 'aresmush/plugin_helpers/visible_target_finder.rb'
require 'aresmush/plugin_helpers/online_char_finder.rb'
require 'aresmush/templates/template_renderer.rb'
require 'aresmush/templates/template_formatters.rb'
require 'aresmush/server.rb'
require 'aresmush/spec_helpers.rb'
require 'aresmush/yaml_file_parser.rb'


