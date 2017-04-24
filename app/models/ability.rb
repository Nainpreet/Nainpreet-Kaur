class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.role == 'admin'
         can :manage, :all
       elsif user.role == 'Doctor'
         can :show, User do |doc|
           doc.id == user.id
         end
         can :edit, Appointment do |app|
            app.doctor.user.id == user.id
         end
         can :index, :appointment
         can :appointment_history, :appointment
       elsif user.role == 'Patient'
         can :show, User do |patient|
           patient.id == user.id
         end
         can :show, Appointment do |app|
           app.user_id == user.id
         end
         can :map, :patient
         can :index, :appointment
         can :appointment_history, :appointment
         can :new , :appointment
         can :new1 , :appointment
       end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
