class Ability
  include CanCan::Ability

  def initialize(user, admin, namespace)
    if namespace == "Admin"
      if admin.kind_of? Admin
        can [:index, :in_publish, :in_reject, :show], Advert
        can [:index, :new, :edit, :create, :update], Category
        can [:index, :user_adverts_with_state ], User
      end
    else
      if user.kind_of? User
        can [:index, :new, :create, :show], Advert
        can [:edit, :update], Advert, user_id:  user.id
        can :in_moderate, Advert, user_id:  user.id, state: "template"
        can :in_archive, Advert, user_id:  user.id, state: "published"
        can :in_newest, Advert, user_id:  user.id, state: ["published", "rejected", "moderated", "archived"]

        can [:create, :destroy], Image
      end
    end
  end
end
