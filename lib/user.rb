require "record"

class User < Record
  attr_reader :watched_repos
  
  def initialize(id)
    super
    @watched_repos = []
  end
  
  def watches(repo)
    @watched_repos << repo
  end
  
  def langs
    @langs ||= @watched_repos.map { |repo| repo.langs.keys }.flatten
  end
  
  def popular_lang
    @popular_lang ||= begin
      langs = Hash.new(0)
      @watched_repos.each { |repo| langs[repo.main_lang] += 1 }
      langs.key_with_max_value
    end
  end
  
  def suggest_repos(n=10)
    (Repo.popular_in(popular_lang) - @watched_repos).first(n)
  end
end