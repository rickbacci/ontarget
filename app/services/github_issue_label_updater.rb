  module GithubIssueLabelUpdater
    def self.call(client_id:, client_secret:, oauth_token:, user:, repo:,
                  number:, labels:)

      github = github_for client_id:     client_id,
                          client_secret: client_secret,
                          oauth_token:   oauth_token,
                          user:          user,
                          repo:          repo


      # github.issues.labels.replace(user, repo, number, labels)
      # github.issues.labels.replace user, repo, number, labels

      # github.issues.labels.replace 'rickbacci', 'ontarget', 18, 'backlog', 'wontfix', 'bug'
      github.issues.labels.replace user, repo, number, "backlog"
      github.issues.labels.replace user, repo, number, "bug"


                                    # "backlog", "bug"
      #

      # github.issues.labels.replace 'user-name', 'repo-name', 'issue-number',
      #   'label1', 'label2', ...

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
