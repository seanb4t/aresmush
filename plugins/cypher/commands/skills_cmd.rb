module AresMUSH
  module Cypher
    class SkillsCmd
      include CommandHandler

      def handle
        skills = Global.read_config('cypher', 'skills')
        list = skills.sort_by { |s| "#{s['type']}/#{s['name']}" }
                      .map { |s| "%xg#{s['name'].ljust(15)}%xn %xw(%xy#{s['type'].ljust(10)}%xw)%xn - #{s['description']}" }
        template = BorderedPagedListTemplate.new(list, cmd.page, 25, t('cypher.skills_title' ))
        client.emit(template.render)
      end
    end
  end
end
