package main

import "core:fmt"
import "core:os"
import "controller"
import "assembly"

main :: proc() {
    my_controller := controller.NewController()
    my_controller.memory[7] = 10
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

    controller.load_code(&my_controller, lines)
    fmt.printf("%08b\n", my_controller.memory[0x25])
    fmt.printf("%08b\n", my_controller.psw)
    for my_controller.pc <= my_controller.last_address {
      controller.exec_instruction(&my_controller)
    }
    fmt.printf("%08b\n", my_controller.memory[0x25])
    fmt.printf("%08b\n", my_controller.psw)
}
