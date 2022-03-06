class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(chars)
    chars.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase) }
  end

  def self.random(length)
    random_peg = []
    length.times { random_peg << POSSIBLE_PEGS.keys.sample }
    Code.new(random_peg)
  end

  def self.from_string(string)
    Code.new(string.split(""))
  end

  def initialize(chars)
    if Code.valid_pegs?(chars) == false
      raise "Does not contain valid pegs"
    else
      @pegs = []
      chars.each { |char| @pegs << char.upcase }
    end
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    correct_colors = 0
    (0...guess.length).each do |idx|
      if guess[idx] == @pegs[idx]
        correct_colors += 1
      end
    end
    correct_colors
  end

  def num_near_matches(guess_code)
    code_dup = self.pegs.dup
    guess_dup = guess_code.pegs.dup

    guess_dup.each_with_index do |peg, i|
      if peg == code_dup[i]
        code_dup[i] = nil
        guess_dup[i] = nil
      end
    end
    code_dup.delete(nil)
    guess_dup.delete(nil)

    count = 0
    guess_dup.each_with_index do |peg, i|
      if code_dup.include?(peg)
        count += 1
        code_dup.delete_at(code_dup.index(peg))
      end
    end
    count
  end

  def ==(other_code)
    other_code.pegs == self.pegs
  end
end
