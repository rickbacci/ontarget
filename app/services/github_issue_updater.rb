  module GithubIssueUpdater
    def self.call(client_id:, client_secret:, oauth_token:, user:, repo:,
                  number:, title:, body:, labels:)

      github = github_for client_id:     client_id,
                          client_secret: client_secret,
                          oauth_token:   oauth_token,
                          user:          user,
                          repo:          repo

      github.issues.edit(number: number,
                         title:    title,
                         body:     body,
                         owner:    user,
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
