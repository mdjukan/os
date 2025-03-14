.section .text

.global __putc
__putc:
    addi    sp, sp, -32
    sd      s0, 16(sp)
    sd      ra, 24(sp)
    addi    s0, sp, 32
    mv      a5, a0
    addi    a1, s0, -17
    li      a2, 1
    li      a0, 0
    sb      a5, -17(s0)
    auipc   ra, 0x0
    jalr    ra # 24 <__putc+0x24>
    ld      ra, 24(sp)
    ld      s0, 16(sp)
    addi    sp, sp, 32
    ret

.global __getc
__getc:
    addi    sp, sp, -32
    sd      s0, 16(sp)
    sd      ra, 24(sp)
    addi    s0, sp, 32
    addi    a1, s0, -24
    li      a2, 1
    li      a0, 0
    auipc   ra, 0x0
    jalr    ra # 58 <__getc+0x1c>
    lbu     a0, -24(s0)
    ld      ra, 24(sp)
    ld      s0, 16(sp)
    addi    sp, sp, 32
    ret

.global console_handler
console_handler:
    addi    sp, sp, -32
    sd      s0, 16(sp)
    sd      ra, 24(sp)
    sd      s1, 8(sp)
    addi    s0, sp, 32
    csrr    a4, scause
    csrr    a5, sstatus
    andi    a5, a5, 2
    bnez    a5, .L17
    bltz    a4, .L18

.L6:
    ld      ra, 24(sp)
    ld      s0, 16(sp)
    ld      s1, 8(sp)
    addi    sp, sp, 32
    ret

.L18:
    zext.b  a4, a4
    li      a5, 9
    bne     a4, a5, .L6
    auipc   ra, 0x0
    jalr    ra # .L18+0xc
    li      a5, 10
    mv      s1, a0
    beq     a0, a5, .L19
    beqz    a0, .L6
    mv      a1, a0
    auipc   a0, 0x0
    mv      a0, a0
    auipc   ra, 0x0
    jalr    ra # .L18+0x30

.L12:
    ld      s0, 16(sp)
    ld      ra, 24(sp)
    mv      a0, s1
    ld      s1, 8(sp)
    addi    sp, sp, 32
    auipc   t1, 0x0
    jr      t1 # .L12+0x14

.L19:
    auipc   ra, 0x0
    jalr    ra # .L19
    j       .L12

.L17:
    auipc   a0, 0x0
    mv      a0, a0
    auipc   ra, 0x0
    jalr    ra # .L17+0x8
