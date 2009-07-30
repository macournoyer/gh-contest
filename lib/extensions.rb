class Hash
  def key_with_max_value
    if entry = sort_by { |_, v| -v }.first
      entry[0]
    end
  end
end