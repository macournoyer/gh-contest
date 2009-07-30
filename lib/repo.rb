require "record"

class Repo < Record
  attr_accessor :name, :created, :fork_of, :langs
  
  def initialize(id)
    super
    @langs = Hash.new(0)
  end
  
  def main_lang
    @main_lang ||= @langs.key_with_max_value
  end
  
  def self.popular_in(lang)
    @@popular ||= {}
    @@popular[lang] ||= begin
      repos = Hash.new(0)
      User.all.select { |id, u| u.popular_lang == lang }.each do |id, user|
        user.watched_repos.each { |id, repo| repos[id] += 1 }
      end
      repos.sort_by { |_, c| -c }.map { |repo, c| repo }
    end
  end
end