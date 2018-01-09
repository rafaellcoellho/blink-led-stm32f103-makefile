/* Includes -----------------------------------------------------------------*/
#include "stm32f1xx_hal.h"

extern void _Error_Handler(char *, int);

/*
 * Initializes the Global MSP.
 */
void HAL_MspInit(void)
{
__HAL_RCC_AFIO_CLK_ENABLE();

HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);

/* System interrupt init*/
/* MemoryManagement_IRQn interrupt configuration */
HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
/* BusFault_IRQn interrupt configuration */
HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
/* UsageFault_IRQn interrupt configuration */
HAL_NVIC_SetPriority(UsageFault_IRQn, 0, 0);
/* SVCall_IRQn interrupt configuration */
HAL_NVIC_SetPriority(SVCall_IRQn, 0, 0);
/* DebugMonitor_IRQn interrupt configuration */
HAL_NVIC_SetPriority(DebugMonitor_IRQn, 0, 0);
/* PendSV_IRQn interrupt configuration */
HAL_NVIC_SetPriority(PendSV_IRQn, 0, 0);
/* SysTick_IRQn interrupt configuration */
HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);

/* DISABLE: JTAG-DP Disabled and SW-DP Disabled */
__HAL_AFIO_REMAP_SWJ_DISABLE();
}

void HAL_TIM_Base_MspInit(TIM_HandleTypeDef *htim_base)
{
if (htim_base->Instance == TIM1) {
	/* Peripheral clock enable */
	__HAL_RCC_TIM1_CLK_ENABLE();
	/* TIM1 interrupt Init */
	HAL_NVIC_SetPriority(TIM1_BRK_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(TIM1_BRK_IRQn);
}
}

void HAL_TIM_Base_MspDeInit(TIM_HandleTypeDef *htim_base)
{
if (htim_base->Instance == TIM1) {
	/* Peripheral clock disable */
	__HAL_RCC_TIM1_CLK_DISABLE();

	/* TIM1 interrupt DeInit */
	HAL_NVIC_DisableIRQ(TIM1_BRK_IRQn);
}
}
