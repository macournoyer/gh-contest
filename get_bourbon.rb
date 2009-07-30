# usage: ruby get_bourbon.rb [last processed user_id]
require "load"

puts "Crunching numbers and getting ready to pour Bourbon..."
if last = ARGV.first
  skip = true
end

File.open('results.txt', last ? 'a' : 'w') do |f|
  Reader.read("data/test.txt", /(\d+)/) do |user_id|
    if skip
      skip = false if user_id == last
      next
    end
    line = user_id + ":" + suggest(user_id).join(",")
    puts line
    f << line
    f << "\n"
  end
end

puts "Gimme the Bourbon!"