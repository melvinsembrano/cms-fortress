class Cms::Fortress::Settings < OpenStruct
  def initialize(config_file_base_name)
    @config_file_base_name = config_file_base_name
    super(load_settings)
  end

  private

  def load_settings
    raise Cms::Fortress::Error::MissingSettingsFile unless config_file_exists?
    YAML.load(ERB.new(File.read(Rails.root.join("config/cms/fortress", "#{@config_file_base_name}.yml"))).result)[Rails.env]
  end

  def config_file_exists?
    File.exist?(File.join(Rails.root, "config/cms/fortress", "#{@config_file_base_name}.yml"))
  end
end
