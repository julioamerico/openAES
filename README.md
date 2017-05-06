O openAES é um projeto open source que disponibiliza um IP Core de um co-processador AES compatível com o protocolo AMBA APB capaz de realizar encriptação e decriptação segundo o padrão AES-128 com suporte aos modos de operação ECB, CBC e CTR. O IP Core do projeto openAES é funcionalmente compatível com o acelerador AES presente na família de microcontroladores STM32L162xx. Através do repositório do projeto são disponibilizados:
  o	O RTL, em Verilog, do IP Core;
  o	Um ambiente de verificação funcional;
  o	Uma camada de abstração de hardware (HAL), escrita em C, compatível com o padrão ARM CMSIS;
	Para propósito de validação, o IP foi prototipado em um dispositivo SmartFusion A2F200M3F. Todos os arquivos necessários para embarcá-lo nessa plataforma também são disponibilizados através do repositório do projeto. 
