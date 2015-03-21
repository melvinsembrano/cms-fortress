class Cms::Fortress::UpgradeGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../../..', __FILE__)

  def generate_migrations
    rake("cms_fortress_engine:install:migrations")
  end

  def copy_files
    log 'Copying files...'
    files = [
      'config/cms/fortress/global_settings.yml'
    ]
    files.each do |file|
      copy_file file, file unless File.exist?(file)
    end
  end

  def done
    # puts "\r\n\r\n!!! IMPORTANT NOTE: Review your existing users since they set to super users as default. Review and assign site roles accordingly."
    puts "Upgrade complete..."
    puts "\r\n\r\n"
  end

end
