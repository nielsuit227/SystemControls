#ifndef __c2_Regulator_Solver_2016_h__
#define __c2_Regulator_Solver_2016_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc2_Regulator_Solver_2016InstanceStruct
#define typedef_SFc2_Regulator_Solver_2016InstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_Regulator_Solver_2016;
  real_T (*c2_Q_T)[36];
  real_T (*c2_Q)[36];
  real_T (*c2_S)[4];
  real_T *c2_D;
  real_T (*c2_C)[2];
  real_T (*c2_B)[2];
  real_T (*c2_A)[4];
} SFc2_Regulator_Solver_2016InstanceStruct;

#endif                                 /*typedef_SFc2_Regulator_Solver_2016InstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c2_Regulator_Solver_2016_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_Regulator_Solver_2016_get_check_sum(mxArray *plhs[]);
extern void c2_Regulator_Solver_2016_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
