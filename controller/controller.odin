package controller

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

NewController :: proc() -> Controller {
    return Controller{
        sp = 0x07,
        pc = 0x00,
    }
}
