class Ability
  include CanCan::Ability

  def initialize(user, admin, namespace)
    can :show, Advert
    if namespace == 'Admin'
      if admin.kind_of? Admin
        can [:index, :show], Advert
        can [:new, :create, :index], Log
        can [:in_publish], Advert, state: 'moderated'
        can [:index, :new, :edit, :create, :update], Category
        can [:index, :user_adverts_with_state], User
      end
    else
      if user.kind_of? User
        can [:index, :new, :create, :show], Advert
        can [:edit, :update], Advert, user_id:  user.id
        can :change_state, Advert, user_id: user.id
        #can :in_moderate, Advert, user_id:  user.id, state: 'template'
        #can :in_archive, Advert, user_id:  user.id, state: 'published'
        #can :in_newest, Advert, user_id:  user.id, state: %w(published rejected moderated archived)

        can [:create, :destroy], Image
      end
    end
  end
end
