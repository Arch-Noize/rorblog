class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id
    can :read, :all

    return unless user.admin?

    can :manage, :all
  end
end
