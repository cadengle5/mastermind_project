require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(new_code)
        puts "exact matches: #{@secret_code.num_exact_matches(new_code)}"
        puts "near matches: #{@secret_code.num_near_matches(new_code)}"
    end

    def ask_user_for_guess
        puts "Enter a code"
        user_string = gets.chomp
        user_code = Code.from_string(user_string)
        self.print_matches(user_code)
        @secret_code == user_code
    end
end
