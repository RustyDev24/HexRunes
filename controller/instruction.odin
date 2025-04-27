package controller

import "core:fmt"

exec_instruction :: proc(controller: ^Controller) {
    inst := controller.rom[controller.pc]
    switch (inst) {
    case 0:
      fmt.println("executing NOP")
      controller.pc += 1
    
    // TODO: AJMP
    case 1:
      target_addr := controller.rom[controller.pc + 1]
      controller.pc =  (controller.pc + 2) & 0xF800
    
    // TODO: LJMP
    case 2:

    // RR A
    case 3:
      fmt.println("executing RR")
      controller.pc += 1
      controller.A = (controller.A >> 1) | (controller.A << 7)

    // INC A
    case 4:
      controller.A += 1
      controller.pc += 1

    // INC (direct)
    case 5:
      controller.memory[controller.rom[controller.pc + 1]] += 1
      controller.pc += 2

    // INC @Ri
    case 6, 7:
      index := inst - 6
      controller.memory[controller.memory[index]] += 1
      controller.pc += 1

    // INC Rx
    case 8..=15:
      index := inst - 8
      controller.memory[index] += 1
      controller.pc += 1

    // TODO: JBC
    case 16:

    case 17:

    case 18:

    // RRC A
    case 19:
      fmt.println("executing RRC")
      controller.pc += 1
      carry := (controller.psw >> 7) & 0x01
      controller.psw = (controller.psw & 0x7F) | ((controller.A & 0x01) << 7)
      controller.A = (controller.A >> 1) | (carry << 7)
    
    // DEC A
    case 20:
      controller.A -= 1
      controller.pc += 1

    // DEC (direct)
    case 21:
      controller.memory[controller.rom[controller.pc + 1]] -= 1
      controller.pc += 2

    // DEC @Ri
    case 22, 23:
      index := inst - 22
      controller.memory[controller.memory[index]] -= 1
      controller.pc += 1

    // DEC Rx
    case 24..=31:
      index := inst - 24
      controller.memory[index] -= 1
      controller.pc += 1

    // TODO: JB
    case 32:

    // TODO: AJMP
    case 33:

    // RET
    case 34:
      pch := controller.memory[controller.sp]
      controller.sp -= 1
      controller.pc = (u16(pch) << 8) | u16(controller.memory[controller.sp])
      controller.sp -= 1

    // RL A
    case 35:
      fmt.println("executing RL")
      controller.pc += 1
      controller.A = (controller.A << 1) | (controller.A >> 7)

    // ADD A, #immed
    case 36:
      controller.A += controller.memory[controller.pc + 1]
      controller.pc += 2

    // ADD A, (direct)  
    case 37:
      controller.A += controller.memory[controller.rom[controller.pc + 1]]
      controller.pc +=2

    // ADD A, @Ri
    case 38, 39:
      index := inst - 38
      controller.A += controller.memory[controller.memory[index]]
      controller.pc += 1

    // ADD A, Rx
    case 40..=47:
      index := inst - 40
      controller.A += controller.memory[index]
      controller.pc += 1

    case 48:
    case 49:
    case 50:
    case 51:
    case 52:
    case 53:
    case 54:
    case 55:
    case 56:
    case 57:
    case 58:
    case 59:
    case 60:
    case 61:
    case 62:
    case 63:
    case 64:
    case 65:
    case 66:
    case 67:
    case 68:
    case 69:
    case 70:
    case 71:
    case 72:
    case 73:
    case 74:
    case 75:
    case 76:
    case 77:
    case 78:
    case 79:
    case 80:
    case 81:
    case 82:
    case 83:
    case 84:
    case 85:
    case 86:
    case 87:
    case 88:
    case 89:
    case 90:
    case 91:
    case 92:
    case 93:
    case 94:
    case 95:
    case 96:
    case 97:
    case 98:
    case 99:
    case 100:
    case 101:
    case 102:
    case 103:
    case 104:
    case 105:
    case 106:
    case 107:
    case 108:
    case 109:
    case 110:
    case 111:
    case 112:
    case 113:
    case 114:
    case 115:
    case 116:
      controller.A = controller.rom[controller.pc + 1]
      controller.pc += 2

    // MOV (direct), #immed  
    case 117:
      controller.memory[controller.rom[controller.pc + 1]] = controller.rom[controller.pc + 1]
      controller.pc += 3

    // MOV @Ri, #immed
    case 118, 119:
      index := inst - 118
      controller.memory[controller.memory[index]] = controller.rom[controller.pc + 1]
      controller.pc += 2

    // MOV Rx, #immed
    case 120..=127:
      index := inst - 120
      controller.memory[index] = controller.rom[controller.pc + 1] 
      controller.pc += 2

    // SJMP
    case 128:
    // AJMP
    case 129:

    // ANL C, bit
    case 130:

    // MOVC A, @A + PC
    case 131:
      controller.pc += 1
      controller.A = controller.rom[u16(controller.A) + controller.pc]

    // DIV AB
    case 132:

    // MOV (dest_direct), (src_direct)
    case 133:
      controller.memory[controller.rom[controller.pc + 2]] = 
        controller.memory[controller.rom[controller.pc + 1]]
      controller.pc += 3

    // MOV (direct), @Ri
    case 134, 135:
      index := inst - 134
      controller.memory[controller.rom[controller.pc + 1]] = controller.memory[controller.memory[index]]
      controller.pc += 2
    
    // MOV (direct), Rx
    case 136..=143:
      index := inst - 134
      controller.memory[controller.rom[controller.pc + 1]] = controller.memory[index]
      controller.pc += 2

    // MOV DPTR, #immed
    case 144:
      controller.dptr = u16((controller.rom[controller.pc + 1] << 8) | (controller.rom[controller.pc + 2]))
      controller.pc += 3

    // ACALL
    case 145:

    // MOV (bit), C
    case 146:

    // MOVC A, @A+DPTR
    case 147:
      controller.A = controller.rom[u16(controller.A) + controller.dptr]
      controller.pc += 1

    // SUBB
    case 148:
    case 149:
    case 150:
    case 151:
    case 152:
    case 153:
    case 154:
    case 155:
    case 156:
    case 157:
    case 158:
    case 159:
    case 160:
    case 161:
    case 162:
    case 163:
    case 164:
    case 165:
    case 166:
    case 167:
    case 168:
    case 169:
    case 170:
    case 171:
    case 172:
    case 173:
    case 174:
    case 175:
    case 176:
    case 177:
    case 178:
    case 179:
    case 180:
    case 181:
    case 182:
    case 183:
    case 184:
    case 185:
    case 186:
    case 187:
    case 188:
    case 189:
    case 190:
    case 191:
    case 192:
    case 193:
    case 194:
    case 195:
    case 196:
    case 197:
    case 198:
    case 199:
    case 200:
    case 201:
    case 202:
    case 203:
    case 204:
    case 205:
    case 206:
    case 207:
    case 208:
    case 209:

    // SETB (bit)
    case 210:
      bit := controller.rom[controller.pc + 1]
      addr := u8(bit / 0x08)
      offset := bit % 0x08

      controller.memory[0x20 + addr] |= (1 << offset)
      controller.pc += 2

    // SETB C
    case 211:
      controller.psw |= (1 << 7)
      controller.pc += 1

    // DA A      
    case 212:
    case 213:
    case 214:
    case 215:
    case 216:
    case 217:
    case 218:
    case 219:
    case 220:
    case 221:
    case 222:
    case 223:
    case 224:
    case 225:
    case 226:
    case 227:
    case 228:
    case 229:
    case 230:
    case 231:
    case 232:
    case 233:
    case 234:
    case 235:
    case 236:
    case 237:
    case 238:
    case 239:
    case 240:
    case 241:
    case 242:
    case 243:
    case 244:
    case 245:
    case 246:
    case 247:
    case 248:
    case 249:
    case 250:
    case 251:
    case 252:
    case 253:
    case 254:
    case 255:
    }
}
