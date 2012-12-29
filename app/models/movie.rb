class Movie
  attr_accessor :cover, :title, :vudu_url

  def initialize(attrs = {})
    attrs.each { |attr, val| instance_variable_set "@#{attr}", val }
    self.cover ||= "http://placehold.it/200x160"
  end

end

