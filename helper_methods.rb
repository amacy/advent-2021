module HelperMethods
  def string_to_number_array(string)
    string.split(//).map(&:to_i)
  end

  def cons(array)
    [array[0], array[1..-1]]
  end

  def bit_to_decimal(string)
    string.to_i(2)
  end
end
