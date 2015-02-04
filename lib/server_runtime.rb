class ServerRuntime
  def self.get_settings
    @server_settings ||= init_settings
    @server_settings
  end

  # Only needs to happen once, since the settings shouldn't change after the server starts
  def self.init_settings
    settings = {}
    settings[:startup_time] = `date`.strip
    settings[:hostname] = `hostname -s`.strip

    begin
      git_file = File.open(Rails.root.join('versions', 'git.txt'))
      if git_file
        rev = git_file.read.strip
        settings[:git_commit] = rev
      end
    rescue
      settings[:git_commit] = `git log --pretty=format:'%H' -n 1`
    end

    migrations = Dir.glob("#{Rails.root}/db/migrate/*.rb")
    current_schema = File.basename(migrations.sort.last).split('_')[0]
    settings[:db_schema] = current_schema
    settings
  end
end
