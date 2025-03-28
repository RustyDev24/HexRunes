package controller

import assembly "../assembly"

Controller :: struct {
    memory: [128]u8,
    rom: [4096]u8,
    psw: u8,
    tcon: u8,
    tmod: u8,
    scon: u8,
    ie: u8,
    sp: u8,
    dptr: u16,
    A: u8,
    B: u8,
    pc: u16,
}

Register :: enum {
    R1 = 0,
    R2,
    R3,
    R4,
    R5,
    R6,
    R7,
    R8
}

load_code :: proc(controller: ^Controller, code: [dynamic]string) {
    for line in code {
        length, address, rec_type, data, checksum, err := assembly.parse_record(line)
        if err != nil {
            break
        }

        for i in 0..<length {
            controller.rom[address + u16(i)] = data[i]
        }
    }

    return
}

NewController :: proc() -> Controller {
    return Controller{
        sp = 0x07,
        pc = 0x00,
    }
}
