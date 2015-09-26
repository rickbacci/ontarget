  module GithubIssueCreater
    def self.call(client_id:, client_secret:, oauth_token:, user:, repo:,
                  title:, body:, labels:)

      github = github_for client_id:     client_id,
                          client_secret: client_secret,
                          oauth_token:   oauth_token,
                          user:          user,
                          repo:          repo

      github.issues.create( title:    title,
                           body:     body,
                           assignee: user,
                           labels:   labels)
    end

    def self.github_for(client_id:, client_secret:, oauth_token:, user:, repo:)
      Github.new do |c|
        c.client_id     = client_id
        c.client_secret = client_secret
        c.oauth_token   = oauth_token
        c.user          = user
        c.repo          = repo
      end
    end
  end
