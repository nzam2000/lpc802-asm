MEMORY
{
    FLASH   (rx)    : ORIGIN = 0x00000000, LENGTH = 0x4000  /* 16 KB */
    SRAM    (rw)    : ORIGIN = 0x10000000, LENGTH = 0x800   /* 2 KB */
}

ENTRY(Reset_Handler)

__StackTop = ORIGIN(SRAM) + LENGTH(SRAM);

SECTIONS
{
    .vectors :
    {
        /* define vector table here for checksum calculation */
        /* address LSB must be 1 for thumb mode */
        LONG(__StackTop);
        LONG(Reset_Handler | 1);
        LONG(Default_Handler | 1);
        LONG(HardFault_Handler | 1);
        LONG(Default_Handler | 1);
        LONG(Default_Handler | 1);
        LONG(Default_Handler | 1);

        /* 2's compliment checksum of entires 0-7 */
        /* required for boot ROM */
        LONG(0 - (
            __StackTop +
            (Reset_Handler | 1) +
            (HardFault_Handler | 1) +
            (4 * (Default_Handler | 1))
        ));

        LONG(0);
        LONG(0);
        LONG(0);
        LONG(Default_Handler | 1);
        LONG(Default_Handler | 1);
        LONG(0);
        LONG(Default_Handler | 1);
        LONG(Default_Handler | 1);

        . = . + 0xB0; /* interrupt vector's flash section is 0xC0 bytes */
    } >FLASH = 0x00

    .text :
    {
         *(.text)
    } >FLASH

    .data : ALIGN(4)
    {
        _sdata = .;
        *(.data)
        . = ALIGN(4);
        _edata = .;
    } >SRAM AT>FLASH

    _sdata_load = LOADADDR(.data);

    .bss :
    {
        _sbss = .;
        *(.bss)
        *(COMMON)
        _ebss = .;
    } >SRAM
}
