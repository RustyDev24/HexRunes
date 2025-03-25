package main

import "core:fmt"
import "core:os"
import "controller"
import "assembly"

main :: proc() {
    myController := controller.NewController()
    myController.memory[7] = 10
    lines, error := assembly.load_file("testing/test.ihx")
    if error != nil {
        switch err in error {
        case assembly.ErrFileReadFailed:
            fmt.printf("error reading file: %s\n", err.filepath)
        case:
            fmt.printf("error: %v\n", err)
        }
        os.exit(1)
    }
    
    for line in lines {
        length, address, rec_type, data, checksum, err := assembly.parse_record(line)
        if err != nil {
            continue
        }

        fmt.printf("length=%d, address=%d, record_type=%d, data=%v, checksum=%d\n",
            length, address, rec_type, data, checksum)
    }
}
