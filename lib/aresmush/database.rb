module AresMUSH  
  class Database

    def connect
      db_env = ENV['ARESMUSH_DB_ENV'] ||= 'production'
      db_config = Global.config['database'][db_env]
      host = db_config['sessions']['default']['hosts']
      db_name = db_config['sessions']['default']['database']
      Global.logger.info("Connection to database[env=#{db_env}]: #{host} #{db_name}")
      begin
        
        Mongoid.load_configuration(db_config)
        Character.all.each do |c|
          puts c.inspect
        end
      rescue Exception => e
        Global.logger.fatal("Error connecting to database.  Please check your dabase configuration and installation requirements: #{e}.")      
        raise e
      end      
    end       
  end
end