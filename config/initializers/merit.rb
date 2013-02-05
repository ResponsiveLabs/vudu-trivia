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

# Acción

Badge.create({
  :id => 20,
  :name => 'arnold',
  :description => 'Arnold Schwarzenegger. Contestaste 3 de accion.'
})

Badge.create({
  :id => 21,
  :name => 'vandamme',
  :description => 'Jean Claude Van Damme. Contestaste 5 de accion.'
})

Badge.create({
  :id => 22,
  :name => 'tom',
  :description => 'Tom Cruise. Contestaste 8 de accion.'
})

Badge.create({
  :id => 23,
  :name => 'milla',
  :description => 'Milla Jovovich. Contestaste 9 de accion.'
})

Badge.create({
  :id => 24,
  :name => 'rock',
  :description => 'The Rock. Contestaste 10 de accion.'
})

# Terror

Badge.create({
  :id => 30,
  :name => 'chucky',
  :description => 'Chucky. Contestaste 5 de terror.'
})

Badge.create({
  :id => 31,
  :name => 'myers',
  :description => 'Michael Myers. Contestaste 7 de terror.'
})

Badge.create({
  :id => 32,
  :name => 'jason',
  :description => 'Jason Voorhees. Contestaste 8 de terror.'
})

Badge.create({
  :id => 33,
  :name => 'freddy',
  :description => 'Freddy Krueger. Contestaste 9 de terror.'
})

Badge.create({
  :id => 34,
  :name => 'eso',
  :description => 'Eso. Contestaste 15 de terror.'
})

# Comedia

Badge.create({
  :id => 40,
  :name => 'jim',
  :description => 'Jim Carey. Contestaste 4 de comedia.'
})

Badge.create({
  :id => 41,
  :name => 'chan',
  :description => 'Jackie Chan. Contestaste 7 de comedia.'
})

Badge.create({
  :id => 42,
  :name => 'murphy',
  :description => 'Eddie Murphy. Contestaste 8 de comedia.'
})

Badge.create({
  :id => 43,
  :name => 'stiller',
  :description => 'Ben Stiller. Contestaste 9 de comedia.'
})

Badge.create({
  :id => 44,
  :name => 'chaplin',
  :description => 'Charles Chaplin. Contestaste 15 de comedia.'
})

