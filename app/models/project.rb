class Project < ActiveRecord::Base
  belongs_to :user
  validates :name, uniqueness: true

  # this is a 'has_may' relationship, but it doesn't exist in the
  # database. It exists with the issues on Github.
  def issues
  end

end
