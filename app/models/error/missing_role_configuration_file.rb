module Error
  # log error to the Rails log
  def self.log_error(name, message)
    Rails.logger.fatal("[ERROR:] in #{name} with message: #{message}\n\n")
  end

  class MissingRoleConfigurationFile < StandardError
    def initialize
      Error.log_error(self, "missing the roles.yml file in config/roles.yml")
    end
  end
end
