    .syntax unified
    .arch armv6-m

    .thumb
    .section .text
    .align 2

    .thumb_func
    .type Reset_Handler, %function
    .global Reset_Handler
Reset_Handler:
    ldr r0, =_sdata_load
    ldr r1, =_sdata
    ldr r2, =_edata
    b .L_CopyData_1
.L_CopyData_0:
    ldr r3, [r0]
    str r3, [r1]
    adds r0, #4
    adds r1, #4
.L_CopyData_1:
    cmp r1, r2
    blt .L_CopyData_0
.L_ZeroBss:

    /* TODO add .size? */

    .thumb_func
    .type HardFault_Handler, %function
    .global HardFault_Handler
HardFault_Handler:
    b .
    /* TODO add .size? */

    .thumb_func
    .type Default_Handler, %function
    .global Default_Handler
Default_Handler:
    b .
    /* TODO add .size? */

    .end
