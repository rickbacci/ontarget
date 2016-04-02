  module GithubCardStatusUpdater
    def self.call(client:, owner:, repo:, number:, old_column:, new_column:)

      client.issues.labels.remove(owner, repo, number, label_name: old_column)
      client.issues.labels.add(owner, repo, number, new_column)
    end
  end
