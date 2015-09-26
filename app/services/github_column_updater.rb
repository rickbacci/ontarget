  module GithubColumnUpdater
    def self.call(owner:, repo:, number:, old_column:, new_column:,
                  oauth_token:, user:, client_id:, client_secret:)

      github = github_for client_id:     client_id,
                          client_secret: client_secret,
                          oauth_token:   oauth_token,
                          user:          user,
                          repo:          repo

      github.issues.labels.remove(owner, repo, number, label_name: old_column)
      github.issues.labels.add(owner, repo, number, new_column)
    end

    def self.update_column
      github.issues.labels.remove(owner, repo, number, label_name: old_column)
      github.issues.labels.add(owner, repo, number, new_column)
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
