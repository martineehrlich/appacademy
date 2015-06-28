def caesar_cipher(offset, string)
result = ""

	string.split("").each do |letter|
		if letter.ord > 122 - offset
			result << (letter.ord + offset - 26).chr
		else
			result << (letter.ord + offset).chr
		end
	end

	return result

end

def caesar_cipher_sentence(offset, string)
	array = string.split(" ")

	array.map! { |word| caesar_cipher(offset, word) }.join(" ")

end


puts caesar_cipher_sentence(2, "abc xyz")
