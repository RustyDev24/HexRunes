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

    controller.load_code(&myController, lines)
    fmt.printf("%v\n", myController.last_address)
    for myController.pc <= myController.last_address {
      controller.exec_instruction(&myController)
    }

    fmt.printf("%v\n", myController)
}
