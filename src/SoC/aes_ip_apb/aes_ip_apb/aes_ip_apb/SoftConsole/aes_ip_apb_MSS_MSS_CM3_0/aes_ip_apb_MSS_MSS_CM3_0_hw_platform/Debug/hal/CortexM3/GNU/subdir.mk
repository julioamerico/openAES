################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../hal/CortexM3/GNU/hal_assert.c 

S_SRCS += \
../hal/CortexM3/GNU/hal.s \
../hal/CortexM3/GNU/hw_reg_access.s 

OBJS += \
./hal/CortexM3/GNU/hal.o \
./hal/CortexM3/GNU/hal_assert.o \
./hal/CortexM3/GNU/hw_reg_access.o 

C_DEPS += \
./hal/CortexM3/GNU/hal_assert.d 


# Each subdirectory must supply rules for building sources it contributes
hal/CortexM3/GNU/%.o: ../hal/CortexM3/GNU/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: GNU Assembler'
	arm-none-eabi-gcc -c -mthumb -mcpu=cortex-m3 -specs=bare.specs  -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

hal/CortexM3/GNU/%.o: ../hal/CortexM3/GNU/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\CMSIS -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_ace -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_nvm -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_rtc -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_uart -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers_config -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers_config\mss_ace -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


