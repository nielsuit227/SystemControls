#ifndef __c6_Adaptive_Output_Regulator_h__
#define __c6_Adaptive_Output_Regulator_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc6_Adaptive_Output_RegulatorInstanceStruct
#define typedef_SFc6_Adaptive_Output_RegulatorInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c6_sfEvent;
  boolean_T c6_doneDoubleBufferReInit;
  uint8_T c6_is_active_c6_Adaptive_Output_Regulator;
  real_T (*c6_E)[8];
  real_T (*c6_vec_EF)[12];
  real_T (*c6_F)[4];
} SFc6_Adaptive_Output_RegulatorInstanceStruct;

#endif                                 /*typedef_SFc6_Adaptive_Output_RegulatorInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c6_Adaptive_Output_Regulator_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c6_Adaptive_Output_Regulator_get_check_sum(mxArray *plhs[]);
extern void c6_Adaptive_Output_Regulator_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
