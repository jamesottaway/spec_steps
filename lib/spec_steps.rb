class SpecSteps
  @@steps = {}

  def self.define sentence, &block
    @@steps[sentence] = block
  end

  def self.execute sentence, *args
    @@steps[sentence].call(*args)
  end
end
