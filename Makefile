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

BUILD_DIR := $(CURDIR)/build

all: $(TARGET) build_info

$(TARGET): $(OBJ)
    # LD_FLAGS must come after due to link order
	$(LD) $(addprefix $(BUILD_DIR)/, $^) $(LD_FLAGS) -o $(BUILD_DIR)/$@ --print-map > $(BUILD_DIR)/$(TARGET)_map.txt
	$(OBJCOPY) -O binary $(BUILD_DIR)/$(TARGET) $(BUILD_DIR)/$(TARGET).bin

%.o: %.S
	$(AS) $(AS_FLAGS) $< -o $(BUILD_DIR)/$@

build_info: $(TARGET)
	$(OBJDUMP) $(BUILD_DIR)/$(TARGET) --disassemble > $(BUILD_DIR)/$(TARGET)_disassembly.txt
	$(OBJDUMP) $(BUILD_DIR)/$(TARGET) --headers > $(BUILD_DIR)/$(TARGET)_headers.txt
	$(NM) $(BUILD_DIR)/$(TARGET) > $(BUILD_DIR)/$(TARGET)_symbols.txt

clean:
	rm -rf build/*
