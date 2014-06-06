module Cms::Fortress::Error
  def self.log_error(name, message)
    Rails.logger.fatal("[ERROR:] in #{name} with message: #{message}\n\n")
  end

  class MissingRoleConfigFile < StandardError
    def initialize
      Cms::Fortress::Error.log_error(self, "missing the roles.yml file in config/roles.yml")
    end
  end

  class MissingSettingsFile < StandardError
    def initialize
      Cms::Fortress::Error.log_error(self, "missing cms-fortress settings file")
    end
  end
end
