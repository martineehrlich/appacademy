require 'set'

class Keypad

  attr_accessor :key_history, :code_bank, :code_length, :mode_keys, :correct_code

  def initialize(code_length = 4, mode_keys = [1,2,3])
    @key_history = ["$", "$","$","$"]
    @code_bank = Set.new
    @mode_keys = mode_keys
    @code_length = code_length
    @correct_code = [1, 2, 3, 4]
  end

  def prompt
    puts "Enter your code and mode."
  end

  def press
    gets.chomp.to_i
  end

  def update_history(current_digit)
    key_history.shift
    key_history.push(current_digit)
  end

  def keypad_reader
    prompt
    until last_digit_is_mode? && code_in_history?
      update_history(press)
      add_to_code_bank if seen?
    end
    display_alarm_status(key_history[-1])
  end

  def add_to_code_bank
    code_bank.add(key_history[0...4])
  end

  def display_alarm_status(mode)
    puts status_hash[mode]
  end

  def last_digit_is_mode?
    mode_keys.include?(key_history[-1])
  end

  def code_in_history?
    key_history[0...4] == correct_code
  end

  def seen?
    !code_bank.include?(key_history[0...4])
  end

end
