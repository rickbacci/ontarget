  module GithubColumnUpdater
    def self.call(client:, number:, old_column:, new_column:)

      client.issues.labels.remove(client.user, client.repo, number, label_name: old_column)
      client.issues.labels.add(client.user, client.repo, number, new_column)
    end
  end
