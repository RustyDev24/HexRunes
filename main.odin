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
    fmt.printf("%v\n", my_controller.last_address)
    for my_controller.pc <= my_controller.last_address {
      // controller.exec_instruction(&my_controller)
      // fmt.printf("A: %08b\n", my_controller.A)
      // fmt.printf("0x20: %08b\n", my_controller.memory[0x20])
      fmt.printf("%02x\n", my_controller.rom[my_controller.pc])
      my_controller.pc += 1
    }
}
