######################################
# target
######################################
TARGET:=blink_led

######################################
# building variables
######################################

# Debug build?
DEBUG:= 1

# Optimization
OPT:= -Og

#######################################
# Paths
#######################################

# Source path
SOURCES_DIR:=  \
src_app \
inc_app \
src_app/main.c \
src_app/stm32f1xx_it.c \
src_app/stm32f1xx_hal_msp.c \
drivers/CMSIS \
drivers \
drivers/STM32F1xx_HAL_Driver

# Firmware library path
PERIFLIB_PATH:=

# Build path
BUILD_DIR:=build

######################################
# Source
######################################

# C sources

C_SOURCES:= \
src_app/main.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c \
src_app/stm32f1xx_it.c \
src_app/stm32f1xx_hal_msp.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c \
src_app/system_stm32f1xx.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c \
drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c


# ASM sources
ASM_SOURCES =  \
startup_stm32f103xb.s

######################################
# Firmware library
######################################
PERIFLIB_SOURCES =

#######################################
# Binaries
#######################################

BINPATH =
PREFIX = arm-none-eabi-
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
AR = $(PREFIX)ar
SZ = $(PREFIX)size
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S

#######################################
# CFLAGS
#######################################

# Cpu
CPU = -mcpu=cortex-m3

# fpu
# NONE for Cortex-M0/M0+/M3

# float-abi


# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

#######################################
# Macros for gcc
#######################################

# AS defines
AS_DEFS =

# C defines
C_DEFS =  \
-DUSE_HAL_DRIVER \
-DSTM32F103xB

# AS includes
AS_INCLUDES =

# C includes
C_INCLUDES =  \
-Iinc_app \
-Idrivers/STM32F1xx_HAL_Driver/Inc \
-Idrivers/STM32F1xx_HAL_Driver/Inc/Legacy \
-Idrivers/CMSIS/Device/ST/STM32F1xx/Include \
-Idrivers/CMSIS/Include

# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif

# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"

#######################################
# LDFLAGS
#######################################

# link script
LDSCRIPT = STM32F103C8Tx_FLASH.ld

# libraries
LIBS = -lc -lm -lnosys
LIBDIR =
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) \
-Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

#######################################
# Build the application
#######################################

all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

# List of objects
OBJECTS=$(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))

# List of ASM program objects
OBJECTS+=$(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@

$(BUILD_DIR):
	mkdir $@
