# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongo_mapper and :mongoid
  # config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to option is given. Default is "User".
  # config.user_model_name = "User"

  # Define :current_user_method. Similar to previous option. It will be used to retrieve :user_model_name object if no :to option is given. Default is "current_#{user_model_name.downcase}".
  # config.current_user_method = "current_user"
end

# Create application badges (uses https://github.com/norman/ambry)

badges = [
  {
    :name => 'arnold',
    :description => 'Arnold Schwarzenegger. Contestaste 3 de accion.'
  },
  {
    :name => 'vandamme',
    :description => 'Jean Claude Van Damme. Contestaste 5 de accion.'
  },
  {
    :name => 'tom',
    :description => 'Tom Cruise. Contestaste 8 de accion.'
  },
  {
    :name => 'milla',
    :description => 'Milla Jovovich. Contestaste 9 de accion.'
  },
  {
    :name => 'rock',
    :description => 'The Rock. Contestaste 10 de accion.'
  },
  {
    :name => 'chucky',
    :description => 'Chucky. Contestaste 5 de terror.'
  },
  {
    :name => 'myers',
    :description => 'Michael Myers. Contestaste 7 de terror.'
  },
  {
    :name => 'jason',
    :description => 'Jason Voorhees. Contestaste 8 de terror.'
  },
  {
    :name => 'freddy',
    :description => 'Freddy Krueger. Contestaste 9 de terror.'
  },
  {
    :name => 'eso',
    :description => 'Eso. Contestaste 15 de terror.'
  },
  {
    :name => 'jim',
    :description => 'Jim Carey. Contestaste 4 de comedia.'
  },
  {
    :name => 'chan',
    :description => 'Jackie Chan. Contestaste 7 de comedia.'
  },
  {
    :name => 'murphy',
    :description => 'Eddie Murphy. Contestaste 8 de comedia.'
  },
  {
    :name => 'stiller',
    :description => 'Ben Stiller. Contestaste 9 de comedia.'
  },
  {
    :name => 'chaplin',
    :description => 'Charles Chaplin. Contestaste 15 de comedia.'
  }
]

badges.each_with_index do |badge, i|
  Badge.create({
    id: i + 1,
    image: Medal.find_by_title(badge[:name]).image,
    name: badge[:name],
    description: badge[:description]
  })
end

