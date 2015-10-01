  module GithubIssueLabelUpdater
    def self.call(client:, number:, labels:)

      client.issues.labels.replace client.user, client.repo, number, labels.shift

      labels.each do |label|
        client.issues.labels.add client.user, client.repo, number, label
      end
    end
  end
