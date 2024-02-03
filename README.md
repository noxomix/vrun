## vtf8
This is a small lib to convert a []u8 into a rune in V.  
It calculates the length of the utf-8 symbol and converts it into 
a rune. An utf-8 symbol (rune) can consist of up to 4 bytes.


### QUICK START:
To install the module simply type: 
```bash
v install noxomix.vtf8
```

### EXAMPLE:
```v
module main
import noxomix.vtf8

fn main() {
	my_bytes := [u8(0xF0), 0x9F, 0x98, 0x80] //😀
	my_rune := vtf8.bytes_to_rune(my_bytes) or {panic(err)}
	println(my_rune)
}
```

### ERROR CODES:  
```
('1') -> The length is not between 0 (1) and 4.  
('2') -> The length is larger then the number of bytes given.  
('3') -> Unspecified.  
```
