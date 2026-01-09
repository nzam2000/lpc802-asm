TARGET := lpc802_asm

TOOLCHAIN := arm-none-eabi
AS := $(TOOLCHAIN)-as
LD := $(TOOLCHAIN)-ld
OBJCOPY := $(TOOLCHAIN)-objcopy
OBJDUMP := $(TOOLCHAIN)-objdump
NM := $(TOOLCHAIN)-nm

AS_FLAGS :=
LD_FLAGS := -T gcc_lpc802.ld

SRC_ASM := startup_lpc802.S main.S
OBJ := $(patsubst %.S, %.o, $(SRC_ASM))

BUILD_DIR := build

all: $(TARGET)

$(TARGET): $(OBJ)
    # LD_FLAGS must come after due to link order
    # TODO specify first file to link on command line (equivalent of using STARTUP())
	$(LD) $(addprefix $(BUILD_DIR)/, $^) $(LD_FLAGS) -o $(BUILD_DIR)/$@ --print-map > $(BUILD_DIR)/$@_map.txt
	$(OBJCOPY) -O binary $(BUILD_DIR)/$@ $(BUILD_DIR)/$@.bin
	$(OBJDUMP) $(BUILD_DIR)/$@ --disassemble > $(BUILD_DIR)/$@_disassembly.txt
	$(OBJDUMP) $(BUILD_DIR)/$@ --headers > $(BUILD_DIR)/$@_sections.txt
	$(NM) $(BUILD_DIR)/$@ > $(BUILD_DIR)/$@_symbols.txt

%.o: %.S
	$(AS) $(AS_FLAGS) $< -o $(BUILD_DIR)/$@
	$(OBJDUMP) $(BUILD_DIR)/$@ --disassemble > $(BUILD_DIR)/$@_disassembly.txt
	$(OBJDUMP) $(BUILD_DIR)/$@ --headers > $(BUILD_DIR)/$@_sections.txt
	$(NM) $(BUILD_DIR)/$@ > $(BUILD_DIR)/$@_symbols.txt

clean:
	rm -rf build/*
