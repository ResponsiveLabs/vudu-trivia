# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+:votes => 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # grant_on 'users#create', :badge => 'just-registered', :to => :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', :badge => 'commenter', :level => 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', :badge => 'relevant-commenter', :to => :user do |comment|
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', :badge => 'autobiographer', :temporary => true, :model_name => 'User' do |user|
      #   user.name.length > 4
      # end

      # Acción

      grant_on 'games#finish', :badge => 'arnold', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Accion') == 3
      end

      grant_on 'games#finish', :badge => 'vandamme', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Accion') == 5
      end

      grant_on 'games#finish', :badge => 'tom', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Accion') == 8
      end

      grant_on 'games#finish', :badge => 'milla', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Accion') == 9
      end

      grant_on 'games#finish', :badge => 'rock', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Accion') == 10
      end

      # Terror

      grant_on 'games#finish', :badge => 'chucky', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Terror') == 5
      end

      grant_on 'games#finish', :badge => 'myers', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Terror') == 7
      end

      grant_on 'games#finish', :badge => 'jason', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Terror') == 8
      end

      grant_on 'games#finish', :badge => 'freddy', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Terror') == 9
      end

      grant_on 'games#finish', :badge => 'eso', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Terror') == 15
      end

      # Comedia

      grant_on 'games#finish', :badge => 'jim', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Comedia') == 4
      end

      grant_on 'games#finish', :badge => 'chan', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Comedia') == 7
      end

      grant_on 'games#finish', :badge => 'murphy', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Comedia') == 8
      end

      grant_on 'games#finish', :badge => 'stiller', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Comedia') == 9
      end

      grant_on 'games#finish', :badge => 'chaplin', :to => :user do |game|
        game.user.number_of_questions_answered_right_and_tagged_as('Comedia') == 15
      end

    end
  end
end
