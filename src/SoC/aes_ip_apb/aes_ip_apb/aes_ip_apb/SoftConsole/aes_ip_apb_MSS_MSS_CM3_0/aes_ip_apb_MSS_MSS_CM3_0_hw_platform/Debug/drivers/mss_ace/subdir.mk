################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/mss_ace/ace_convert.c \
../drivers/mss_ace/ace_flags.c \
../drivers/mss_ace/ace_sse.c \
../drivers/mss_ace/ace_transform.c \
../drivers/mss_ace/mss_ace.c 

OBJS += \
./drivers/mss_ace/ace_convert.o \
./drivers/mss_ace/ace_flags.o \
./drivers/mss_ace/ace_sse.o \
./drivers/mss_ace/ace_transform.o \
./drivers/mss_ace/mss_ace.o 

C_DEPS += \
./drivers/mss_ace/ace_convert.d \
./drivers/mss_ace/ace_flags.d \
./drivers/mss_ace/ace_sse.d \
./drivers/mss_ace/ace_transform.d \
./drivers/mss_ace/mss_ace.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/mss_ace/%.o: ../drivers/mss_ace/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\CMSIS -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_ace -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_gpio -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_nvm -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_pdma -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_rtc -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_timer -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers\mss_uart -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers_config -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\drivers_config\mss_ace -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal\CortexM3 -IE:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\SoftConsole\aes_ip_apb_MSS_MSS_CM3_0\aes_ip_apb_MSS_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


