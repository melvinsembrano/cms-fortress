require 'test_helper'

class Cms::Fortress::SettingsTest < ActiveSupport::TestCase

  test "it_should_raise_MissingConfigFile_exception" do
    assert_raises (Cms::Fortress::Error::MissingSettingsFile) {
      Cms::Fortress::Settings.new(:bla)
    }
  end

  test "test_it_should_return_the_config_file" do
    settings = Cms::Fortress::Settings.new(:global_settings)
    assert_equal(settings.title, 'CMS Fortress')
  end

end
