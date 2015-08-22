module AresMUSH

  module FS3Skills
    class SetRulingAptCmd
      include Plugin
      include PluginRequiresLogin
      include PluginRequiresArgs
      include PluginWithoutSwitches
      
      attr_accessor :name, :ruling_apt

      def initialize
        self.required_args = ['name', 'ruling_apt']
        self.help_topic = 'skills'
        super
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("rulingapt")
      end

      def crack!
        cmd.crack_args!(CommonCracks.arg1_equals_arg2)
        self.name = titleize_input(cmd.args.arg1)
        self.ruling_apt = trim_input(cmd.args.arg2)
      end
      
      def check_valid_attr
        return nil if self.ruling_apt.nil?
        return t('fs3skills.invalid_aptitude', :name => self.ruling_apt) if !FS3Skills.aptitude_names.include?(self.ruling_apt)
        return nil
      end
      
      def check_name
        ability_type = FS3Skills.get_ability_type(client.char, self.name)
        invalid_types = [:action, :advantage, :aptitude]
        return t('fs3skills.cant_change_fixed_ruling_apts') if invalid_types.include?(ability_type)
        return nil
      end
        
      def handle
        if (FS3Skills.ability_rating(client.char, self.name) == 0)
          client.emit_failure t('fs3skills.invalid_ability_for_ruling_apt', :ability => self.name)
          return
        end
        
        client.char.fs3_ruling_apts[self.name] = self.ruling_apt
        client.char.save
        client.emit_success t('fs3skills.ruling_apt_set', :ability => self.name, :ruling_apt => self.ruling_apt)
      end
    end
  end
end
