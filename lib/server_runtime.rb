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
    settings[:git_commit] = `git log --pretty=format:'%H' -n 1`
    settings[:git_commit_data] = `git log --pretty=format:'%ad' -n 1`

    if settings[:git_commit].blank?
      begin
        git_file = File.open(Rails.root.join('git.json'))
        if git_file
          rev = JSON.parse git_file.read.strip
          Rails.logger.info 'Using git info from git.json'
          settings.merge! rev
        end
      rescue
        Rails.logger.error 'No git.json file; you should run ./git-info.sh.'
      end
    end

    migrations = Dir.glob("#{Rails.root}/db/migrate/*.rb")
    current_schema = File.basename(migrations.sort.last).split('_')[0]
    settings[:db_schema] = current_schema
    settings
  end
end
