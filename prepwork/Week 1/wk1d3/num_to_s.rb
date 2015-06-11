def num_to_s(num, base)
  string_num = ""


  hexadecimal =  {10 => "A",
    11 => "B",
    12 => "C",
    13 => "D",
    14 => "E",
    15 => "F",
    }

    divider = 1
    while num / divider > 0 
      if base == 16
        if (num / (divider) % base) > 9
          string_num = hexadecimal[(num / (divider) % base)] + string_num
        else
          string_num = (num / (divider) % base).to_s + string_num
        end
      else
      string_num = (num / (divider) % base).to_s + string_num
      end
      divider *= base
    end

    string_num
end

puts num_to_s(234, 10)
puts num_to_s(234, 2)
puts num_to_s(234, 16)
