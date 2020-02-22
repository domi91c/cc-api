class Object
  def if_true
    yield
    self
  end

  def if_false
    self
  end
end

class NilClass
  def if_true
    self
  end

  def if_false; end
end

(1 == 3).if_false { p 'hello' }
