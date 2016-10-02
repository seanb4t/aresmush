module AresMUSH
  module Pose
    module Api
      def self.autospace(char)
        char.autospace
      end
      
      def self.repose_on(room)
        Pose.repose_on(room)
      end
    end
  end
  
  class PoseEvent
    attr_accessor :enactor, :pose, :is_emit
    def initialize(enactor, pose, is_emit)
      @enactor = enactor
      @pose = pose
      @is_emit = is_emit
    end
  end
end