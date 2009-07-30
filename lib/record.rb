class Record
  attr_reader :id
  
  def initialize(id)
    @id = id
    self.class.all[id] = self
  end
  
  def self.all
    @all ||= {}
  end

  def self.all=(v)
    @all = v
  end
  
  def self.[](id)
    all[id] || new(id)
  end
end