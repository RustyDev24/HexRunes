package assembly

import "core:os"
import "core:strings"
import "core:fmt"

FileError :: union {
    ErrFileReadFailed,
}

ErrFileReadFailed :: struct {
    filepath: string,
}

load_file :: proc(filepath: string) -> ([dynamic]string, FileError) {
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok {
        return nil, ErrFileReadFailed{filepath}
    }

    lines: [dynamic]string = {}
    it := string(data)

    for line in strings.split_lines_iterator(&it) {
        append(&lines, line)
    }

    fmt.printf("%v\n", lines)
    return lines, nil
}
