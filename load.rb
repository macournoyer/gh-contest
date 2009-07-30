$:.unshift File.dirname(__FILE__) + "/lib"

# Call this to reload in console
def reload!
  load "extensions.rb"
  load "record.rb"
  load "user.rb"
  load "repo.rb"
  load "reader.rb"
end
reload!

puts "Reading data ..."

Reader.read("data/data.txt", /^(\d+)\:(\d+)$/) do |user_id, repo_id|
  User[user_id].watches Repo[repo_id]
end

Reader.read("data/repos.txt", /^(\d+)\:([\w\/-_]+),([\d-]+),(\d+)?$/) do |repo_id, name, created, fork_of|
  repo = Repo[repo_id]
  repo.name = name
  repo.created = created
  repo.fork_of = Repo[fork_of] if fork_of
end

Reader.read("data/lang.txt", /^(\d+)\:(.+)$/) do |repo_id, langs|
  repo = Repo[repo_id]
  langs.split(",").each do |lang|
    name, lines = *lang.split(";")
    repo.langs[name] += lines.to_i
  end
end

puts "Done reading #{User.all.size} users and #{Repo.all.size} repos"

# Helpers to experiment in console
def suggest(user_id)
  User[user_id].suggest_repos.map { |repo| repo.id }
end
