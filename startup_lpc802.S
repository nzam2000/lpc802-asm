    .syntax unified
    .arch armv6-m

    .thumb
    .section .text
    .align 2

    .thumb_func
    .type Reset_Handler, %function
    .global Reset_Handler
Reset_Handler:
    ldr r0, =_etext
    ldr r1, =_sdata
    ldr r2, =_edata
.L_copy_data_0:
    cmp r1, r2
    /* TODO */

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
