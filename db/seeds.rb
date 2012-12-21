# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'json'

Question.delete_all

JSON.parse(File.read("#{Rails.root}/db/seeds/questions.json")).each do |q|
  Question.create!(q)
end

