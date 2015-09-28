  module GithubIssueLabelUpdater
    def self.call(client_id:, client_secret:, oauth_token:, user:, repo:,
                  number:, labels:)

      github = github_for client_id:     client_id,
                          client_secret: client_secret,
                          oauth_token:   oauth_token,
                          user:          user,
                          repo:          repo

      github.issues.labels.replace user, repo, number, labels.shift

      labels.each do |label|
        github.issues.labels.add user, repo, number, label
      end
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
