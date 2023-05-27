# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.role == 'admin'
      can :delete, Post
      can :delete, Comment
    else
      can :delete, Post, author_id: user.id
      can :delete, Comment, author_id: user.id
    end
  end
end
