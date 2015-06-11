def caesar_cipher(string, offset)
result = ""
	idx = 0
	while idx < string.length
		if string[idx].ord > 122 - offset
			code = string[idx].ord + offset - 26
		else
		code = string[idx].ord + offset
	end
		result += code.chr
		idx += 1
	end

	return result

end

def caesar_cipher_sentence(offset, string)
array = string.split(" ")
	idx = 0
	while idx < array.length
		array[idx] = caesar_cipher(offset, array[idx])
		idx += 1
	end

	return array.join(" ")

end


puts caesar_cipher_sentence(2, "abc xyz")
