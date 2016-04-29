################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/fabric_aes/fabric_aes.c 

OBJS += \
./drivers/fabric_aes/fabric_aes.o 

C_DEPS += \
./drivers/fabric_aes/fabric_aes.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/fabric_aes/%.o: ../drivers/fabric_aes/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\CMSIS -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_ace -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_nvm -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_rtc -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_uart -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers_config -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers_config\mss_ace -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


