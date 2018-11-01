module AresMUSH
  class Character < Ohm::Model
    collection :cypher_skills, 'AresMUSH::CypherSkill'
    collection :cypher_attributes, 'AresMUSH::CypherAttribute'
    attribute :cypher_descriptor
    attribute :cypher_type
    attribute :cypher_focus
    attribute :cypher_tier
    attribute :cypher_effort
    attribute :cypher_xp
  end

  class CypherAttribute < Ohm::Model
    include ObjectModel
    attribute :name
    attribute :pool
    attribute :pool_current_value
    attribute :edge
    reference :character, 'AresMUSH::Character'
    index :name
  end

  class CypherSkill < Ohm::Model
    include ObjectModel
    attribute :name
    attribute :base_attribute
    reference :character, 'AresMUSH::Character'
    index :name
  end
end