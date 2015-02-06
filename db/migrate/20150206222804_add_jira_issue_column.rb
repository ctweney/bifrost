class AddJiraIssueColumn < ActiveRecord::Migration
  def change
    add_column(:application, :jira_issue, :string)
  end
end
