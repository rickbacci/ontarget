  module GithubIssueCreater
    def self.call(client:, title:, body:, labels:)

      client.issues.create(title:    title,
                           body:     body,
                           assignee: client.user,
                           labels:   labels)
    end
  end
