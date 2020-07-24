/* Include files */

#include "Adaptive_Output_Regulator_sfun.h"
#include "Adaptive_Output_Regulator_sfun_debug_macros.h"
#include "c3_Adaptive_Output_Regulator.h"
#include "c6_Adaptive_Output_Regulator.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
uint32_T _Adaptive_Output_RegulatorMachineNumber_;

/* Function Declarations */

/* Function Definitions */
void Adaptive_Output_Regulator_initializer(void)
{
}

void Adaptive_Output_Regulator_terminator(void)
{
}

/* SFunction Glue Code */
unsigned int sf_Adaptive_Output_Regulator_method_dispatcher(SimStruct
  *simstructPtr, unsigned int chartFileNumber, const char* specsCksum, int_T
  method, void *data)
{
  if (chartFileNumber==3) {
    c3_Adaptive_Output_Regulator_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==6) {
    c6_Adaptive_Output_Regulator_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  return 0;
}

unsigned int sf_Adaptive_Output_Regulator_process_check_sum_call( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[20];
  if (nrhs<1 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the checksum */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"sf_get_check_sum"))
    return 0;
  plhs[0] = mxCreateDoubleMatrix( 1,4,mxREAL);
  if (nrhs>1 && mxIsChar(prhs[1])) {
    mxGetString(prhs[1], commandName,sizeof(commandName)/sizeof(char));
    commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
    if (!strcmp(commandName,"machine")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(924094081U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1359386428U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(692276658U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(815160836U);
    } else if (nrhs==3 && !strcmp(commandName,"chart")) {
      unsigned int chartFileNumber;
      chartFileNumber = (unsigned int)mxGetScalar(prhs[2]);
      switch (chartFileNumber) {
       case 3:
        {
          extern void sf_c3_Adaptive_Output_Regulator_get_check_sum(mxArray
            *plhs[]);
          sf_c3_Adaptive_Output_Regulator_get_check_sum(plhs);
          break;
        }

       case 6:
        {
          extern void sf_c6_Adaptive_Output_Regulator_get_check_sum(mxArray
            *plhs[]);
          sf_c6_Adaptive_Output_Regulator_get_check_sum(plhs);
          break;
        }

       default:
        ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0.0);
      }
    } else if (!strcmp(commandName,"target")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3429898665U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(479754071U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3100092396U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1773797558U);
    } else {
      return 0;
    }
  } else {
    ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1117663536U);
    ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(492388181U);
    ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3216475881U);
    ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1231123875U);
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_Adaptive_Output_Regulator_autoinheritance_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[32];
  char aiChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the autoinheritance_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_autoinheritance_info"))
    return 0;
  mxGetString(prhs[2], aiChksum,sizeof(aiChksum)/sizeof(char));
  aiChksum[(sizeof(aiChksum)/sizeof(char)-1)] = '\0';

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 3:
      {
        if (strcmp(aiChksum, "yIGLrNBBB6xrjn6b68o7hE") == 0) {
          extern mxArray
            *sf_c3_Adaptive_Output_Regulator_get_autoinheritance_info(void);
          plhs[0] = sf_c3_Adaptive_Output_Regulator_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 6:
      {
        if (strcmp(aiChksum, "We8F6rhZpZjwhZpM2il15G") == 0) {
          extern mxArray
            *sf_c6_Adaptive_Output_Regulator_get_autoinheritance_info(void);
          plhs[0] = sf_c6_Adaptive_Output_Regulator_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_Adaptive_Output_Regulator_get_eml_resolved_functions_info( int
  nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[64];
  if (nrhs<2 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the get_eml_resolved_functions_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_eml_resolved_functions_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 3:
      {
        extern const mxArray
          *sf_c3_Adaptive_Output_Regulator_get_eml_resolved_functions_info(void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c3_Adaptive_Output_Regulator_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 6:
      {
        extern const mxArray
          *sf_c6_Adaptive_Output_Regulator_get_eml_resolved_functions_info(void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c6_Adaptive_Output_Regulator_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_Adaptive_Output_Regulator_third_party_uses_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the third_party_uses_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_third_party_uses_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 3:
      {
        if (strcmp(tpChksum, "suRiQvpQyu4f2ynwj9q6mu") == 0) {
          extern mxArray *sf_c3_Adaptive_Output_Regulator_third_party_uses_info
            (void);
          plhs[0] = sf_c3_Adaptive_Output_Regulator_third_party_uses_info();
          break;
        }
      }

     case 6:
      {
        if (strcmp(tpChksum, "sta8hD4GXBwy36Lsunx6IVE") == 0) {
          extern mxArray *sf_c6_Adaptive_Output_Regulator_third_party_uses_info
            (void);
          plhs[0] = sf_c6_Adaptive_Output_Regulator_third_party_uses_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_Adaptive_Output_Regulator_jit_fallback_info( int nlhs, mxArray *
  plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the jit_fallback_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_jit_fallback_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 3:
      {
        if (strcmp(tpChksum, "suRiQvpQyu4f2ynwj9q6mu") == 0) {
          extern mxArray *sf_c3_Adaptive_Output_Regulator_jit_fallback_info(void);
          plhs[0] = sf_c3_Adaptive_Output_Regulator_jit_fallback_info();
          break;
        }
      }

     case 6:
      {
        if (strcmp(tpChksum, "sta8hD4GXBwy36Lsunx6IVE") == 0) {
          extern mxArray *sf_c6_Adaptive_Output_Regulator_jit_fallback_info(void);
          plhs[0] = sf_c6_Adaptive_Output_Regulator_jit_fallback_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_Adaptive_Output_Regulator_updateBuildInfo_args_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the updateBuildInfo_args_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_updateBuildInfo_args_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 3:
      {
        if (strcmp(tpChksum, "suRiQvpQyu4f2ynwj9q6mu") == 0) {
          extern mxArray
            *sf_c3_Adaptive_Output_Regulator_updateBuildInfo_args_info(void);
          plhs[0] = sf_c3_Adaptive_Output_Regulator_updateBuildInfo_args_info();
          break;
        }
      }

     case 6:
      {
        if (strcmp(tpChksum, "sta8hD4GXBwy36Lsunx6IVE") == 0) {
          extern mxArray
            *sf_c6_Adaptive_Output_Regulator_updateBuildInfo_args_info(void);
          plhs[0] = sf_c6_Adaptive_Output_Regulator_updateBuildInfo_args_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

void Adaptive_Output_Regulator_debug_initialize(struct SfDebugInstanceStruct*
  debugInstance)
{
  _Adaptive_Output_RegulatorMachineNumber_ = sf_debug_initialize_machine
    (debugInstance,"Adaptive_Output_Regulator","sfun",0,4,0,0,0);
  sf_debug_set_machine_event_thresholds(debugInstance,
    _Adaptive_Output_RegulatorMachineNumber_,0,0);
  sf_debug_set_machine_data_thresholds(debugInstance,
    _Adaptive_Output_RegulatorMachineNumber_,0);
}

void Adaptive_Output_Regulator_register_exported_symbols(SimStruct* S)
{
}

static mxArray* sRtwOptimizationInfoStruct= NULL;
typedef struct SfOptimizationInfoFlagsTag {
  boolean_T isRtwGen;
  boolean_T isModelRef;
  boolean_T isExternal;
} SfOptimizationInfoFlags;

static SfOptimizationInfoFlags sOptimizationInfoFlags;
void unload_Adaptive_Output_Regulator_optimization_info(void);
mxArray* load_Adaptive_Output_Regulator_optimization_info(boolean_T isRtwGen,
  boolean_T isModelRef, boolean_T isExternal)
{
  if (sOptimizationInfoFlags.isRtwGen != isRtwGen ||
      sOptimizationInfoFlags.isModelRef != isModelRef ||
      sOptimizationInfoFlags.isExternal != isExternal) {
    unload_Adaptive_Output_Regulator_optimization_info();
  }

  sOptimizationInfoFlags.isRtwGen = isRtwGen;
  sOptimizationInfoFlags.isModelRef = isModelRef;
  sOptimizationInfoFlags.isExternal = isExternal;
  if (sRtwOptimizationInfoStruct==NULL) {
    sRtwOptimizationInfoStruct = sf_load_rtw_optimization_info(
      "Adaptive_Output_Regulator", "Adaptive_Output_Regulator");
    mexMakeArrayPersistent(sRtwOptimizationInfoStruct);
  }

  return(sRtwOptimizationInfoStruct);
}

void unload_Adaptive_Output_Regulator_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct!=NULL) {
    mxDestroyArray(sRtwOptimizationInfoStruct);
    sRtwOptimizationInfoStruct = NULL;
  }
}
