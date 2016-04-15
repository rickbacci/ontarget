  module GithubIssueCreater
    def self.call(client:, title:, body:, milestone:, labels:)

      client.issues.create(title:    title,
                           body:     body,
                           assignee: client.user,
                           milestone: milestone,
                           labels:   labels)
    end
  end
