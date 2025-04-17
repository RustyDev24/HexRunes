#!/bin/bash
ASM_FILE=$1
BASE_NAME=${ASM_FILE%.asm}

sdas8051 -o $ASM_FILE
sdld -i $BASE_NAME.hex $BASE_NAME.rel