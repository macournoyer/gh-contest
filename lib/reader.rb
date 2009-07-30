class Reader
  def initialize(file)
    @file = file
  end
  
  def read(pattern)
    io = File.new(@file)
    while !io.eof? && line = io.readline
      if matches = line.match(pattern)
        yield *matches[1..-1]
      end
    end
  ensure
    io.close
  end
  
  def self.read(file, pattern, &block)
    new(file).read(pattern, &block)
  end
end