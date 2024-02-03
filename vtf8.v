module vtf8

/*
| This Module is made for the conversion from []u8 into rune.
| There is also implemented features to read (buffered) from a File
| into []runes to iterate over it as an example.
| 
| ERROR CODES:
| (1) -> The length is not between 0 (1) and 4.
| (2) -> The length is larger then the number of bytes given.
| (3) -> Unspecified.
*/

pub fn bytes_to_rune(byte_array []u8) !rune {
	mut first_byte := byte_array[0]
	mut num_bytes := get_num_bytes(byte_array)!

	mut codepoint := u32(first_byte & (0xFF >> (num_bytes + 1)))
    for i := 1; i < num_bytes; i++ {
        if (byte_array[i] & 0xC0) != 0x80 {
            return error('3')
        }
        codepoint = (codepoint << 6) | (byte_array[i] & 0x3F)
    }

	return rune(codepoint)
}

pub fn get_num_bytes(byte_array []u8) !u8 {
	mut num_bytes := u8(0)
	for (byte_array[0] & (1 << (7 - num_bytes))) > 0 {
    	num_bytes++
	}
	if num_bytes < 0 || num_bytes > 4 {
        return error('1')
    }
	if num_bytes > byte_array.len {
		return error('2')
	}
	return num_bytes
}