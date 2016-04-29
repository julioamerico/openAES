/**
  ******************************************************************************
  * @file    fabric_aes.h
  * @author  Julio Cesar
  * @version V1.0
  * @date    08-July-2014
  * @brief   This file contains all the functions prototypes for the AES firmware
  *          library.
  ******************************************************************************
  * @attention
  *
  * This code is adapted from library developed by STMicroelectronics
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __FABRIC_AES_H
#define __FABRIC_AES_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "../../CMSIS/a2fxxxm3.h"
#include "../aes_ip_apb_hw_platform.h"

/** @addtogroup AES
  * @{
  */

/* Exported types ------------------------------------------------------------*/
 /**
   * @brief AES hardware accelerator
   */
 typedef struct
 {
   __IO uint32_t CR;           /*!< AES control register,                        Address offset: 0x00 */
   __IO uint32_t SR;           /*!< AES status register,                         Address offset: 0x04 */
   __IO uint32_t DINR;         /*!< AES data input register,                     Address offset: 0x08 */
   __IO uint32_t DOUTR;        /*!< AES data output register,                    Address offset: 0x0C */
   __IO uint32_t KEYR0;        /*!< AES key register 0,                          Address offset: 0x10 */
   __IO uint32_t KEYR1;        /*!< AES key register 1,                          Address offset: 0x14 */
   __IO uint32_t KEYR2;        /*!< AES key register 2,                          Address offset: 0x18 */
   __IO uint32_t KEYR3;        /*!< AES key register 3,                          Address offset: 0x1C */
   __IO uint32_t IVR0;         /*!< AES initialization vector register 0,        Address offset: 0x20 */
   __IO uint32_t IVR1;         /*!< AES initialization vector register 1,        Address offset: 0x24 */
   __IO uint32_t IVR2;         /*!< AES initialization vector register 2,        Address offset: 0x28 */
   __IO uint32_t IVR3;         /*!< AES initialization vector register 3,        Address offset: 0x2C */
 } AES_TypeDef;

#define AES                 ((AES_TypeDef *) AES_IP_0)

 typedef enum {RESET = 0, SET = !RESET} FlagStatus, ITStatus;

 typedef enum {DISABLE = 0, ENABLE = !DISABLE} FunctionalState;

 #define IS_FUNCTIONAL_STATE(STATE) (((STATE) == DISABLE) || ((STATE) == ENABLE))

 typedef enum {ERROR = 0, SUCCESS = !ERROR} ErrorStatus;
 /*******************  Bit definition for AES_CR register  *********************/
 #define  AES_CR_EN                           ((uint32_t)0x00000001)        /*!< AES Enable */
 #define  AES_CR_DATATYPE                     ((uint32_t)0x00000006)        /*!< Data type selection */
 #define  AES_CR_DATATYPE_0                   ((uint32_t)0x00000002)        /*!< Bit 0 */
 #define  AES_CR_DATATYPE_1                   ((uint32_t)0x00000004)        /*!< Bit 1 */

 #define  AES_CR_MODE                         ((uint32_t)0x00000018)        /*!< AES Mode Of Operation */
 #define  AES_CR_MODE_0                       ((uint32_t)0x00000008)        /*!< Bit 0 */
 #define  AES_CR_MODE_1                       ((uint32_t)0x00000010)        /*!< Bit 1 */

 #define  AES_CR_CHMOD                        ((uint32_t)0x00000060)        /*!< AES Chaining Mode */
 #define  AES_CR_CHMOD_0                      ((uint32_t)0x00000020)        /*!< Bit 0 */
 #define  AES_CR_CHMOD_1                      ((uint32_t)0x00000040)        /*!< Bit 1 */

 #define  AES_CR_CCFC                         ((uint32_t)0x00000080)        /*!< Computation Complete Flag Clear */
 #define  AES_CR_ERRC                         ((uint32_t)0x00000100)        /*!< Error Clear */
 #define  AES_CR_CCIE                         ((uint32_t)0x00000200)        /*!< Computation Complete Interrupt Enable */
 #define  AES_CR_ERRIE                        ((uint32_t)0x00000400)        /*!< Error Interrupt Enable */
 #define  AES_CR_DMAINEN                      ((uint32_t)0x00000800)        /*!< DMA ENable managing the data input phase */
 #define  AES_CR_DMAOUTEN                     ((uint32_t)0x00001000)        /*!< DMA Enable managing the data output phase */

 /*******************  Bit definition for AES_SR register  *********************/
 #define  AES_SR_CCF                          ((uint32_t)0x00000001)        /*!< Computation Complete Flag */
 #define  AES_SR_RDERR                        ((uint32_t)0x00000002)        /*!< Read Error Flag */
 #define  AES_SR_WRERR                        ((uint32_t)0x00000004)        /*!< Write Error Flag */

 /*******************  Bit definition for AES_DINR register  *******************/
 #define  AES_DINR                            ((uint32_t)0x0000FFFF)        /*!< AES Data Input Register */

 /*******************  Bit definition for AES_DOUTR register  ******************/
 #define  AES_DOUTR                           ((uint32_t)0x0000FFFF)        /*!< AES Data Output Register */

 /*******************  Bit definition for AES_KEYR0 register  ******************/
 #define  AES_KEYR0                           ((uint32_t)0x0000FFFF)        /*!< AES Key Register 0 */

 /*******************  Bit definition for AES_KEYR1 register  ******************/
 #define  AES_KEYR1                           ((uint32_t)0x0000FFFF)        /*!< AES Key Register 1 */

 /*******************  Bit definition for AES_KEYR2 register  ******************/
 #define  AES_KEYR2                           ((uint32_t)0x0000FFFF)        /*!< AES Key Register 2 */

 /*******************  Bit definition for AES_KEYR3 register  ******************/
 #define  AES_KEYR3                           ((uint32_t)0x0000FFFF)        /*!< AES Key Register 3 */

 /*******************  Bit definition for AES_IVR0 register  *******************/
 #define  AES_IVR0                            ((uint32_t)0x0000FFFF)        /*!< AES Initialization Vector Register 0 */

 /*******************  Bit definition for AES_IVR1 register  *******************/
 #define  AES_IVR1                            ((uint32_t)0x0000FFFF)        /*!< AES Initialization Vector Register 1 */

 /*******************  Bit definition for AES_IVR2 register  *******************/
 #define  AES_IVR2                            ((uint32_t)0x0000FFFF)        /*!< AES Initialization Vector Register 2 */

 /*******************  Bit definition for AES_IVR3 register  *******************/
 #define  AES_IVR3                            ((uint32_t)0x0000FFFF)        /*!< AES Initialization Vector Register 3 */
/**
  * @brief   AES Init structure definition
  */
typedef struct
{
  uint32_t AES_Operation; /*!< Specifies the AES mode of operation.
                               This parameter can be a value of @ref AES_possible_Operation_modes */
  uint32_t AES_Chaining;  /*!< Specifies the AES Chaining modes: ECB, CBC or CTR.
                               This parameter can be a value of @ref AES_possible_chaining_modes */
  uint32_t AES_DataType;  /*!< Specifies the AES data swapping: 32-bit, 16-bit, 8-bit or 1-bit.
                               This parameter can be a value of @ref AES_Data_Types */
}AES_InitTypeDef;

/**
  * @brief   AES Key(s) structure definition
  */
typedef struct
{
  uint32_t AES_Key0;  /*!< Key[31:0]   */
  uint32_t AES_Key1;  /*!< Key[63:32]  */
  uint32_t AES_Key2;  /*!< Key[95:64]  */
  uint32_t AES_Key3;  /*!< Key[127:96] */
}AES_KeyInitTypeDef;

/**
  * @brief   AES Initialization Vectors (IV) structure definition
  */
typedef struct
{
  uint32_t AES_IV0;  /*!< Init Vector IV[31:0]   */
  uint32_t AES_IV1;  /*!< Init Vector IV[63:32]  */
  uint32_t AES_IV2;  /*!< Init Vector IV[95:64]  */
  uint32_t AES_IV3;  /*!< Init Vector IV[127:96] */
}AES_IVInitTypeDef;

/* Exported constants --------------------------------------------------------*/

/** @defgroup AES_Exported_Constants
  * @{
  */

/** @defgroup AES_possible_Operation_modes
  * @{
  */
#define AES_Operation_Encryp               ((uint32_t)0x00000000) /*!< AES in Encryption mode */
#define AES_Operation_KeyDeriv             AES_CR_MODE_0          /*!< AES in Key Derivation mode */
#define AES_Operation_Decryp               AES_CR_MODE_1          /*!< AES in Decryption mode */
#define AES_Operation_KeyDerivAndDecryp    AES_CR_MODE            /*!< AES in Key Derivation and Decryption mode */

#define IS_AES_MODE(OPERATION) (((OPERATION) == AES_Operation_Encryp)    || \
                                ((OPERATION) == AES_Operation_KeyDeriv)  || \
                                ((OPERATION) == AES_Operation_Decryp)    || \
                                ((OPERATION) == AES_Operation_KeyDerivAndDecryp))

/**
  * @}
  */

/** @defgroup AES_possible_chaining_modes
  * @{
  */
#define AES_Chaining_ECB                   ((uint32_t)0x00000000) /*!< AES in ECB chaining mode */
#define AES_Chaining_CBC                   AES_CR_CHMOD_0         /*!< AES in CBC chaining mode */
#define AES_Chaining_CTR                   AES_CR_CHMOD_1         /*!< AES in CTR chaining mode */

#define IS_AES_CHAINING(CHAINING) (((CHAINING) == AES_Chaining_ECB) || \
                                   ((CHAINING) == AES_Chaining_CBC) || \
                                   ((CHAINING) == AES_Chaining_CTR))
/**
  * @}
  */

/** @defgroup AES_Data_Types
  * @{
  */
#define AES_DataType_32b                   ((uint32_t)0x00000000) /*!< 32-bit data. No swapping */
#define AES_DataType_16b                   AES_CR_DATATYPE_0      /*!< 16-bit data. Each half word is swapped */
#define AES_DataType_8b                    AES_CR_DATATYPE_1      /*!< 8-bit data. All bytes are swapped */
#define AES_DataType_1b                    AES_CR_DATATYPE        /*!< 1-bit data. In the word all bits are swapped */

#define IS_AES_DATATYPE(DATATYPE) (((DATATYPE) == AES_DataType_32b) || \
                                    ((DATATYPE) == AES_DataType_16b)|| \
                                    ((DATATYPE) == AES_DataType_8b) || \
                                    ((DATATYPE) == AES_DataType_1b))
/**
  * @}
  */

/** @defgroup AES_Flags
  * @{
  */
#define AES_FLAG_CCF                       AES_SR_CCF    /*!< Computation Complete Flag */
#define AES_FLAG_RDERR                     AES_SR_RDERR  /*!< Read Error Flag           */
#define AES_FLAG_WRERR                     AES_SR_WRERR  /*!< Write Error Flag          */

#define IS_AES_FLAG(FLAG) (((FLAG) == AES_FLAG_CCF)    || \
                           ((FLAG) == AES_FLAG_RDERR)  || \
                           ((FLAG) == AES_FLAG_WRERR))
/**
  * @}
  */

/** @defgroup AES_Interrupts
  * @{
  */
#define AES_IT_CC                          AES_CR_CCIE  /*!< Computation Complete interrupt */
#define AES_IT_ERR                         AES_CR_ERRIE /*!< Error interrupt                */

#define IS_AES_IT(IT) ((((IT) & (uint32_t)0xFFFFF9FF) == 0x00) && ((IT) != 0x00))
#define IS_AES_GET_IT(IT) (((IT) == AES_IT_CC) || ((IT) == AES_IT_ERR))

/**
  * @}
  */

/** @defgroup AES_DMA_Transfer_modes
  * @{
  */
#define AES_DMATransfer_In                 AES_CR_DMAINEN                     /*!< DMA requests enabled for input transfer phase */
#define AES_DMATransfer_Out                AES_CR_DMAOUTEN                    /*!< DMA requests enabled for input transfer phase */
#define AES_DMATransfer_InOut              (AES_CR_DMAINEN | AES_CR_DMAOUTEN) /*!< DMA requests enabled for both input and output phases */

#define IS_AES_DMA_TRANSFER(TRANSFER)   (((TRANSFER) == AES_DMATransfer_In)  || \
                                         ((TRANSFER) == AES_DMATransfer_Out)  || \
                                         ((TRANSFER) == AES_DMATransfer_InOut))
/**
  * @}
  */

/**
  * @}
  */

/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

/* Initialization and configuration functions *********************************/
void AES_DeInit(void);
void AES_Init(AES_InitTypeDef* AES_InitStruct);
void AES_KeyInit(AES_KeyInitTypeDef* AES_KeyInitStruct);
void AES_IVInit(AES_IVInitTypeDef* AES_IVInitStruct);
void AES_Cmd(FunctionalState NewState);

/* Structures initialization functions ****************************************/
void AES_StructInit(AES_InitTypeDef* AES_InitStruct);
void AES_KeyStructInit(AES_KeyInitTypeDef* AES_KeyInitStruct);
void AES_IVStructInit(AES_IVInitTypeDef* AES_IVInitStruct);

/* AES Read and Write functions **********************************************/
void AES_WriteSubData(uint32_t Data);
uint32_t AES_ReadSubData(void);
void AES_ReadKey(AES_KeyInitTypeDef* AES_KeyInitStruct);
void AES_ReadIV(AES_IVInitTypeDef* AES_IVInitStruct);

/* DMA transfers management function ******************************************/
void AES_DMAConfig(uint32_t AES_DMATransfer, FunctionalState NewState);

/* Interrupts and flags management functions **********************************/
void AES_ITConfig(uint32_t AES_IT, FunctionalState NewState);
FlagStatus AES_GetFlagStatus(uint32_t AES_FLAG);
void AES_ClearFlag(uint32_t AES_FLAG);
ITStatus AES_GetITStatus(uint32_t AES_IT);
void AES_ClearITPendingBit(uint32_t AES_IT);

/* High Level AES functions **************************************************/
ErrorStatus AES_ECB_Encrypt(uint8_t* Key, uint8_t* Input, uint32_t Ilength, uint8_t* Output);
ErrorStatus AES_ECB_Decrypt(uint8_t* Key, uint8_t* Input, uint32_t Ilength, uint8_t* Output);
ErrorStatus AES_CBC_Encrypt(uint8_t* Key, uint8_t InitVectors[16], uint8_t* Input, uint32_t Ilength, uint8_t* Output);
ErrorStatus AES_CBC_Decrypt(uint8_t* Key, uint8_t InitVectors[16], uint8_t* Input, uint32_t Ilength, uint8_t* Output);
ErrorStatus AES_CTR_Encrypt(uint8_t* Key, uint8_t InitVectors[16], uint8_t* Input, uint32_t Ilength, uint8_t* Output);
ErrorStatus AES_CTR_Decrypt(uint8_t* Key, uint8_t InitVectors[16], uint8_t* Input, uint32_t Ilength, uint8_t* Output);

#ifdef __cplusplus
}
#endif

#endif /*__FABRIC_AES_H */

/**
  * @}
  */

/**
  * @}
  */

/******END OF FILE****/

