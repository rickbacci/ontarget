  module GithubIssueUpdater
    def self.call(client:, number:, title:, body:, labels:)

      client.issues.edit(number: number,
                         title:    title,
                         body:     body,
                         owner:    client.user,
                         labels:   labels)
    end
  end
