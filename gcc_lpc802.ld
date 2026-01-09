MEMORY
{
    FLASH   (rx)    : ORIGIN = 0x00000000, LENGTH = 0x4000  /* 16 KB */
    SRAM    (rw)    : ORIGIN = 0x10000000, LENGTH = 0x800   /* 2 KB */
}

ENTRY(_start)

SECTIONS
{
    .text :
    {
         *(.vectors)
         *(.text)
    } >FLASH

    .data :
    {
        _sdata = .;
        *(.data)
        _edata = .;
    } >SRAM AT>FLASH

    .bss :
    {
        _sbss = .;
        *(.bss)
        *(COMMON)
        _ebss = .;
    } >SRAM
}