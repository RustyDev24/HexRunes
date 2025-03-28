package assembly

import "core:strings"
import "core:strconv"
import "core:fmt"

ParseError :: union {
    InvalidRecord,
}

InvalidRecord :: struct {
}

parse_record :: proc(line: string) -> (
    length: u8,
    address: u16,
    record_type: u8,
    data: []u8,
    checksum: u8,
    err: ParseError
) {
    if (line[0] != ':') {
        fmt.printf("%v\n", line[0])
        err = InvalidRecord{}
        return
    }

    length = u8(hex_to_uint(line[1:3]))
    address = u16(hex_to_uint(line[3:7]))
    record_type = u8(hex_to_uint(line[7:9]))

    data = make([]u8, length)
    for i := 0; i < int(length); i += 1 {
        data[i] = u8(hex_to_uint(string(line[9 + i*2 : 11 + i*2])))
    }

    checksum = u8(hex_to_uint(string(line[9 + length*2 : 11 + length*2])))

    return
}

hex_to_uint :: proc(hex: string) -> uint {
    value, _ := strconv.parse_u64(hex, 16)
    return uint(value)
}

