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
    last_address: u16,
}

load_code :: proc(controller: ^Controller, code: [dynamic]string) {
  for line in code {
    length, address, rec_type, data, checksum, err := assembly.parse_record(line)
    if err != nil {
      break
    }

    if rec_type == 1 {
      break
    }
  
    if final_address := address + u16(length); final_address > controller.last_address {
      controller.last_address = final_address
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
    pc = 0x0020,
    last_address = 0x0000,
  }
}
