/* Include files */

#include "Adaptive_Output_Regulator_sfun.h"
#include "c6_Adaptive_Output_Regulator.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "Adaptive_Output_Regulator_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c_with_debugger(S, sfGlobalDebugInstanceStruct);

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization);
static void chart_debug_initialize_data_addresses(SimStruct *S);
static const mxArray* sf_opaque_get_hover_data_for_msg(void *chartInstance,
  int32_T msgSSID);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const char * c6_debug_family_names[9] = { "Ec", "Er", "Fc", "Fr",
  "nargin", "nargout", "E", "F", "vec_EF" };

/* Function Declarations */
static void initialize_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void initialize_params_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void enable_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void disable_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void c6_update_debugger_state_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void set_sim_state_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_st);
static void finalize_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void sf_gateway_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void mdl_start_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void initSimStructsc6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c6_machineNumber, uint32_T
  c6_chartNumber, uint32_T c6_instanceNumber);
static const mxArray *c6_sf_marshallOut(void *chartInstanceVoid, void *c6_inData);
static void c6_emlrt_marshallIn(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c6_b_vec_EF, const char_T *c6_identifier,
  real_T c6_y[12]);
static void c6_b_emlrt_marshallIn(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c6_u, const emlrtMsgIdentifier *c6_parentId,
  real_T c6_y[12]);
static void c6_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c6_mxArrayInData, const char_T *c6_varName, void *c6_outData);
static const mxArray *c6_b_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData);
static const mxArray *c6_c_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData);
static const mxArray *c6_d_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData);
static real_T c6_c_emlrt_marshallIn(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c6_u, const emlrtMsgIdentifier *c6_parentId);
static void c6_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c6_mxArrayInData, const char_T *c6_varName, void *c6_outData);
static const mxArray *c6_e_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData);
static int32_T c6_d_emlrt_marshallIn
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_u, const emlrtMsgIdentifier *c6_parentId);
static void c6_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c6_mxArrayInData, const char_T *c6_varName, void *c6_outData);
static uint8_T c6_e_emlrt_marshallIn
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_b_is_active_c6_Adaptive_Output_Regulator, const char_T *c6_identifier);
static uint8_T c6_f_emlrt_marshallIn
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_u, const emlrtMsgIdentifier *c6_parentId);
static void init_dsm_address_info(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc6_Adaptive_Output_Regulator(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c6_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c6_is_active_c6_Adaptive_Output_Regulator = 0U;
}

static void initialize_params_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c6_update_debugger_state_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  const mxArray *c6_st;
  const mxArray *c6_y = NULL;
  const mxArray *c6_b_y = NULL;
  uint8_T c6_hoistedGlobal;
  const mxArray *c6_c_y = NULL;
  c6_st = NULL;
  c6_st = NULL;
  c6_y = NULL;
  sf_mex_assign(&c6_y, sf_mex_createcellmatrix(2, 1), false);
  c6_b_y = NULL;
  sf_mex_assign(&c6_b_y, sf_mex_create("y", *chartInstance->c6_vec_EF, 0, 0U, 1U,
    0U, 1, 12), false);
  sf_mex_setcell(c6_y, 0, c6_b_y);
  c6_hoistedGlobal = chartInstance->c6_is_active_c6_Adaptive_Output_Regulator;
  c6_c_y = NULL;
  sf_mex_assign(&c6_c_y, sf_mex_create("y", &c6_hoistedGlobal, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c6_y, 1, c6_c_y);
  sf_mex_assign(&c6_st, c6_y, false);
  return c6_st;
}

static void set_sim_state_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_st)
{
  const mxArray *c6_u;
  real_T c6_dv0[12];
  int32_T c6_i0;
  chartInstance->c6_doneDoubleBufferReInit = true;
  c6_u = sf_mex_dup(c6_st);
  c6_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell("vec_EF", c6_u, 0)),
                      "vec_EF", c6_dv0);
  for (c6_i0 = 0; c6_i0 < 12; c6_i0++) {
    (*chartInstance->c6_vec_EF)[c6_i0] = c6_dv0[c6_i0];
  }

  chartInstance->c6_is_active_c6_Adaptive_Output_Regulator =
    c6_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(
    "is_active_c6_Adaptive_Output_Regulator", c6_u, 1)),
    "is_active_c6_Adaptive_Output_Regulator");
  sf_mex_destroy(&c6_u);
  c6_update_debugger_state_c6_Adaptive_Output_Regulator(chartInstance);
  sf_mex_destroy(&c6_st);
}

static void finalize_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  int32_T c6_i1;
  int32_T c6_i2;
  int32_T c6_i3;
  int32_T c6_i4;
  real_T c6_b_E[8];
  uint32_T c6_debug_family_var_map[9];
  real_T c6_b_F[4];
  real_T c6_Ec;
  real_T c6_Er;
  real_T c6_Fc;
  real_T c6_Fr;
  real_T c6_nargin = 2.0;
  real_T c6_nargout = 1.0;
  real_T c6_b_vec_EF[12];
  int32_T c6_i5;
  int32_T c6_i6;
  int32_T c6_i7;
  int32_T c6_i8;
  int32_T c6_i9;
  int32_T c6_i10;
  real_T c6_x[12];
  int32_T c6_k;
  int32_T c6_i11;
  int32_T c6_i12;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 3U, chartInstance->c6_sfEvent);
  for (c6_i1 = 0; c6_i1 < 4; c6_i1++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c6_F)[c6_i1], 1U, 1U, 0U,
                          chartInstance->c6_sfEvent, false);
  }

  for (c6_i2 = 0; c6_i2 < 8; c6_i2++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c6_E)[c6_i2], 0U, 1U, 0U,
                          chartInstance->c6_sfEvent, false);
  }

  chartInstance->c6_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 3U, chartInstance->c6_sfEvent);
  for (c6_i3 = 0; c6_i3 < 8; c6_i3++) {
    c6_b_E[c6_i3] = (*chartInstance->c6_E)[c6_i3];
  }

  for (c6_i4 = 0; c6_i4 < 4; c6_i4++) {
    c6_b_F[c6_i4] = (*chartInstance->c6_F)[c6_i4];
  }

  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 9U, 9U, c6_debug_family_names,
    c6_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c6_Ec, 0U, c6_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c6_Er, 1U, c6_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c6_Fc, 2U, c6_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c6_Fr, 3U, c6_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c6_nargin, 4U, c6_d_sf_marshallOut,
    c6_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c6_nargout, 5U, c6_d_sf_marshallOut,
    c6_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c6_b_E, 6U, c6_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c6_b_F, 7U, c6_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c6_b_vec_EF, 8U, c6_sf_marshallOut,
    c6_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c6_sfEvent, 2);
  c6_Ec = 2.0;
  c6_Er = 4.0;
  _SFD_EML_CALL(0U, chartInstance->c6_sfEvent, 3);
  c6_Fc = 1.0;
  c6_Fr = 4.0;
  _SFD_EML_CALL(0U, chartInstance->c6_sfEvent, 4);
  c6_i5 = 0;
  c6_i6 = 0;
  for (c6_i7 = 0; c6_i7 < 4; c6_i7++) {
    for (c6_i9 = 0; c6_i9 < 2; c6_i9++) {
      c6_x[c6_i9 + c6_i5] = c6_b_E[c6_i9 + c6_i6];
    }

    c6_i5 += 3;
    c6_i6 += 2;
  }

  c6_i8 = 0;
  for (c6_i10 = 0; c6_i10 < 4; c6_i10++) {
    c6_x[c6_i8 + 2] = c6_b_F[c6_i10];
    c6_i8 += 3;
  }

  for (c6_k = 0; c6_k + 1 < 13; c6_k++) {
    c6_b_vec_EF[c6_k] = c6_x[c6_k];
  }

  _SFD_EML_CALL(0U, chartInstance->c6_sfEvent, -4);
  _SFD_SYMBOL_SCOPE_POP();
  for (c6_i11 = 0; c6_i11 < 12; c6_i11++) {
    (*chartInstance->c6_vec_EF)[c6_i11] = c6_b_vec_EF[c6_i11];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 3U, chartInstance->c6_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_Adaptive_Output_RegulatorMachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
  for (c6_i12 = 0; c6_i12 < 12; c6_i12++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c6_vec_EF)[c6_i12], 2U, 1U, 0U,
                          chartInstance->c6_sfEvent, false);
  }
}

static void mdl_start_c6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void initSimStructsc6_Adaptive_Output_Regulator
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c6_machineNumber, uint32_T
  c6_chartNumber, uint32_T c6_instanceNumber)
{
  (void)c6_machineNumber;
  (void)c6_chartNumber;
  (void)c6_instanceNumber;
}

static const mxArray *c6_sf_marshallOut(void *chartInstanceVoid, void *c6_inData)
{
  const mxArray *c6_mxArrayOutData;
  int32_T c6_i13;
  const mxArray *c6_y = NULL;
  real_T c6_u[12];
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_mxArrayOutData = NULL;
  c6_mxArrayOutData = NULL;
  for (c6_i13 = 0; c6_i13 < 12; c6_i13++) {
    c6_u[c6_i13] = (*(real_T (*)[12])c6_inData)[c6_i13];
  }

  c6_y = NULL;
  sf_mex_assign(&c6_y, sf_mex_create("y", c6_u, 0, 0U, 1U, 0U, 1, 12), false);
  sf_mex_assign(&c6_mxArrayOutData, c6_y, false);
  return c6_mxArrayOutData;
}

static void c6_emlrt_marshallIn(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c6_b_vec_EF, const char_T *c6_identifier,
  real_T c6_y[12])
{
  emlrtMsgIdentifier c6_thisId;
  c6_thisId.fIdentifier = c6_identifier;
  c6_thisId.fParent = NULL;
  c6_thisId.bParentIsCell = false;
  c6_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c6_b_vec_EF), &c6_thisId, c6_y);
  sf_mex_destroy(&c6_b_vec_EF);
}

static void c6_b_emlrt_marshallIn(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c6_u, const emlrtMsgIdentifier *c6_parentId,
  real_T c6_y[12])
{
  real_T c6_dv1[12];
  int32_T c6_i14;
  (void)chartInstance;
  sf_mex_import(c6_parentId, sf_mex_dup(c6_u), c6_dv1, 1, 0, 0U, 1, 0U, 1, 12);
  for (c6_i14 = 0; c6_i14 < 12; c6_i14++) {
    c6_y[c6_i14] = c6_dv1[c6_i14];
  }

  sf_mex_destroy(&c6_u);
}

static void c6_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c6_mxArrayInData, const char_T *c6_varName, void *c6_outData)
{
  const mxArray *c6_b_vec_EF;
  const char_T *c6_identifier;
  emlrtMsgIdentifier c6_thisId;
  real_T c6_y[12];
  int32_T c6_i15;
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_b_vec_EF = sf_mex_dup(c6_mxArrayInData);
  c6_identifier = c6_varName;
  c6_thisId.fIdentifier = c6_identifier;
  c6_thisId.fParent = NULL;
  c6_thisId.bParentIsCell = false;
  c6_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c6_b_vec_EF), &c6_thisId, c6_y);
  sf_mex_destroy(&c6_b_vec_EF);
  for (c6_i15 = 0; c6_i15 < 12; c6_i15++) {
    (*(real_T (*)[12])c6_outData)[c6_i15] = c6_y[c6_i15];
  }

  sf_mex_destroy(&c6_mxArrayInData);
}

static const mxArray *c6_b_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData)
{
  const mxArray *c6_mxArrayOutData;
  int32_T c6_i16;
  const mxArray *c6_y = NULL;
  real_T c6_u[4];
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_mxArrayOutData = NULL;
  c6_mxArrayOutData = NULL;
  for (c6_i16 = 0; c6_i16 < 4; c6_i16++) {
    c6_u[c6_i16] = (*(real_T (*)[4])c6_inData)[c6_i16];
  }

  c6_y = NULL;
  sf_mex_assign(&c6_y, sf_mex_create("y", c6_u, 0, 0U, 1U, 0U, 2, 1, 4), false);
  sf_mex_assign(&c6_mxArrayOutData, c6_y, false);
  return c6_mxArrayOutData;
}

static const mxArray *c6_c_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData)
{
  const mxArray *c6_mxArrayOutData;
  int32_T c6_i17;
  int32_T c6_i18;
  const mxArray *c6_y = NULL;
  int32_T c6_i19;
  real_T c6_u[8];
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_mxArrayOutData = NULL;
  c6_mxArrayOutData = NULL;
  c6_i17 = 0;
  for (c6_i18 = 0; c6_i18 < 4; c6_i18++) {
    for (c6_i19 = 0; c6_i19 < 2; c6_i19++) {
      c6_u[c6_i19 + c6_i17] = (*(real_T (*)[8])c6_inData)[c6_i19 + c6_i17];
    }

    c6_i17 += 2;
  }

  c6_y = NULL;
  sf_mex_assign(&c6_y, sf_mex_create("y", c6_u, 0, 0U, 1U, 0U, 2, 2, 4), false);
  sf_mex_assign(&c6_mxArrayOutData, c6_y, false);
  return c6_mxArrayOutData;
}

static const mxArray *c6_d_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData)
{
  const mxArray *c6_mxArrayOutData;
  real_T c6_u;
  const mxArray *c6_y = NULL;
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_mxArrayOutData = NULL;
  c6_mxArrayOutData = NULL;
  c6_u = *(real_T *)c6_inData;
  c6_y = NULL;
  sf_mex_assign(&c6_y, sf_mex_create("y", &c6_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c6_mxArrayOutData, c6_y, false);
  return c6_mxArrayOutData;
}

static real_T c6_c_emlrt_marshallIn(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c6_u, const emlrtMsgIdentifier *c6_parentId)
{
  real_T c6_y;
  real_T c6_d0;
  (void)chartInstance;
  sf_mex_import(c6_parentId, sf_mex_dup(c6_u), &c6_d0, 1, 0, 0U, 0, 0U, 0);
  c6_y = c6_d0;
  sf_mex_destroy(&c6_u);
  return c6_y;
}

static void c6_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c6_mxArrayInData, const char_T *c6_varName, void *c6_outData)
{
  const mxArray *c6_nargout;
  const char_T *c6_identifier;
  emlrtMsgIdentifier c6_thisId;
  real_T c6_y;
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_nargout = sf_mex_dup(c6_mxArrayInData);
  c6_identifier = c6_varName;
  c6_thisId.fIdentifier = c6_identifier;
  c6_thisId.fParent = NULL;
  c6_thisId.bParentIsCell = false;
  c6_y = c6_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c6_nargout), &c6_thisId);
  sf_mex_destroy(&c6_nargout);
  *(real_T *)c6_outData = c6_y;
  sf_mex_destroy(&c6_mxArrayInData);
}

const mxArray *sf_c6_Adaptive_Output_Regulator_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c6_nameCaptureInfo = NULL;
  c6_nameCaptureInfo = NULL;
  sf_mex_assign(&c6_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c6_nameCaptureInfo;
}

static const mxArray *c6_e_sf_marshallOut(void *chartInstanceVoid, void
  *c6_inData)
{
  const mxArray *c6_mxArrayOutData;
  int32_T c6_u;
  const mxArray *c6_y = NULL;
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_mxArrayOutData = NULL;
  c6_mxArrayOutData = NULL;
  c6_u = *(int32_T *)c6_inData;
  c6_y = NULL;
  sf_mex_assign(&c6_y, sf_mex_create("y", &c6_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c6_mxArrayOutData, c6_y, false);
  return c6_mxArrayOutData;
}

static int32_T c6_d_emlrt_marshallIn
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_u, const emlrtMsgIdentifier *c6_parentId)
{
  int32_T c6_y;
  int32_T c6_i20;
  (void)chartInstance;
  sf_mex_import(c6_parentId, sf_mex_dup(c6_u), &c6_i20, 1, 6, 0U, 0, 0U, 0);
  c6_y = c6_i20;
  sf_mex_destroy(&c6_u);
  return c6_y;
}

static void c6_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c6_mxArrayInData, const char_T *c6_varName, void *c6_outData)
{
  const mxArray *c6_b_sfEvent;
  const char_T *c6_identifier;
  emlrtMsgIdentifier c6_thisId;
  int32_T c6_y;
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c6_b_sfEvent = sf_mex_dup(c6_mxArrayInData);
  c6_identifier = c6_varName;
  c6_thisId.fIdentifier = c6_identifier;
  c6_thisId.fParent = NULL;
  c6_thisId.bParentIsCell = false;
  c6_y = c6_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c6_b_sfEvent),
    &c6_thisId);
  sf_mex_destroy(&c6_b_sfEvent);
  *(int32_T *)c6_outData = c6_y;
  sf_mex_destroy(&c6_mxArrayInData);
}

static uint8_T c6_e_emlrt_marshallIn
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_b_is_active_c6_Adaptive_Output_Regulator, const char_T *c6_identifier)
{
  uint8_T c6_y;
  emlrtMsgIdentifier c6_thisId;
  c6_thisId.fIdentifier = c6_identifier;
  c6_thisId.fParent = NULL;
  c6_thisId.bParentIsCell = false;
  c6_y = c6_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c6_b_is_active_c6_Adaptive_Output_Regulator), &c6_thisId);
  sf_mex_destroy(&c6_b_is_active_c6_Adaptive_Output_Regulator);
  return c6_y;
}

static uint8_T c6_f_emlrt_marshallIn
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c6_u, const emlrtMsgIdentifier *c6_parentId)
{
  uint8_T c6_y;
  uint8_T c6_u0;
  (void)chartInstance;
  sf_mex_import(c6_parentId, sf_mex_dup(c6_u), &c6_u0, 1, 3, 0U, 0, 0U, 0);
  c6_y = c6_u0;
  sf_mex_destroy(&c6_u);
  return c6_y;
}

static void init_dsm_address_info(SFc6_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  chartInstance->c6_E = (real_T (*)[8])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c6_vec_EF = (real_T (*)[12])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c6_F = (real_T (*)[4])ssGetInputPortSignal_wrapper
    (chartInstance->S, 1);
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c6_Adaptive_Output_Regulator_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(291437822U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(2933777861U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2021162247U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2225987456U);
}

mxArray* sf_c6_Adaptive_Output_Regulator_get_post_codegen_info(void);
mxArray *sf_c6_Adaptive_Output_Regulator_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("We8F6rhZpZjwhZpM2il15G");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(2);
      pr[1] = (double)(4);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(4);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,1,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(12);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxArray* mxPostCodegenInfo =
      sf_c6_Adaptive_Output_Regulator_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c6_Adaptive_Output_Regulator_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c6_Adaptive_Output_Regulator_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("pre");
  mxArray *fallbackReason = mxCreateString("hasBreakpoints");
  mxArray *hiddenFallbackType = mxCreateString("none");
  mxArray *hiddenFallbackReason = mxCreateString("");
  mxArray *incompatibleSymbol = mxCreateString("");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c6_Adaptive_Output_Regulator_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c6_Adaptive_Output_Regulator_get_post_codegen_info(void)
{
  const char* fieldNames[] = { "exportedFunctionsUsedByThisChart",
    "exportedFunctionsChecksum" };

  mwSize dims[2] = { 1, 1 };

  mxArray* mxPostCodegenInfo = mxCreateStructArray(2, dims, sizeof(fieldNames)/
    sizeof(fieldNames[0]), fieldNames);

  {
    mxArray* mxExportedFunctionsChecksum = mxCreateString("");
    mwSize exp_dims[2] = { 0, 1 };

    mxArray* mxExportedFunctionsUsedByThisChart = mxCreateCellArray(2, exp_dims);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsUsedByThisChart",
               mxExportedFunctionsUsedByThisChart);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsChecksum",
               mxExportedFunctionsChecksum);
  }

  return mxPostCodegenInfo;
}

static const mxArray *sf_get_sim_state_info_c6_Adaptive_Output_Regulator(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"vec_EF\",},{M[8],M[0],T\"is_active_c6_Adaptive_Output_Regulator\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c6_Adaptive_Output_Regulator_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance =
      (SFc6_Adaptive_Output_RegulatorInstanceStruct *)sf_get_chart_instance_ptr
      (S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _Adaptive_Output_RegulatorMachineNumber_,
           6,
           1,
           1,
           0,
           3,
           0,
           0,
           0,
           0,
           0,
           &chartInstance->chartNumber,
           &chartInstance->instanceNumber,
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation(_Adaptive_Output_RegulatorMachineNumber_,
          chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,
             _Adaptive_Output_RegulatorMachineNumber_,chartInstance->chartNumber,
             1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _Adaptive_Output_RegulatorMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"E");
          _SFD_SET_DATA_PROPS(1,1,1,0,"F");
          _SFD_SET_DATA_PROPS(2,2,0,1,"vec_EF");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,107);

        {
          unsigned int dimVector[2];
          dimVector[0]= 2U;
          dimVector[1]= 4U;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c6_c_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 1U;
          dimVector[1]= 4U;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c6_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 12U;
          _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c6_sf_marshallOut,(MexInFcnForType)
            c6_sf_marshallIn);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _Adaptive_Output_RegulatorMachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static void chart_debug_initialize_data_addresses(SimStruct *S)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance =
      (SFc6_Adaptive_Output_RegulatorInstanceStruct *)sf_get_chart_instance_ptr
      (S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(0U, *chartInstance->c6_E);
        _SFD_SET_DATA_VALUE_PTR(2U, *chartInstance->c6_vec_EF);
        _SFD_SET_DATA_VALUE_PTR(1U, *chartInstance->c6_F);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "sta8hD4GXBwy36Lsunx6IVE";
}

static void sf_opaque_initialize_c6_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  chart_debug_initialization(((SFc6_Adaptive_Output_RegulatorInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
  initialize_c6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c6_Adaptive_Output_Regulator(void *chartInstanceVar)
{
  enable_c6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c6_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  disable_c6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c6_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  sf_gateway_c6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c6_Adaptive_Output_Regulator
  (SimStruct* S)
{
  return get_sim_state_c6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct *)sf_get_chart_instance_ptr(S));/* raw sim ctx */
}

static void sf_opaque_set_sim_state_c6_Adaptive_Output_Regulator(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct*)sf_get_chart_instance_ptr(S),
     st);
}

static void sf_opaque_terminate_c6_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc6_Adaptive_Output_RegulatorInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Adaptive_Output_Regulator_optimization_info();
    }

    finalize_c6_Adaptive_Output_Regulator
      ((SFc6_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc6_Adaptive_Output_Regulator
    ((SFc6_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c6_Adaptive_Output_Regulator(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c6_Adaptive_Output_Regulator
      ((SFc6_Adaptive_Output_RegulatorInstanceStruct*)sf_get_chart_instance_ptr
       (S));
  }
}

static void mdlSetWorkWidths_c6_Adaptive_Output_Regulator(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetStatesModifiedOnlyInUpdate(S, 1);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_Adaptive_Output_Regulator_optimization_info
      (sim_mode_is_rtw_gen(S), sim_mode_is_modelref_sim(S), sim_mode_is_external
       (S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,6);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,6,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 6);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,6);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,6,2);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,6,1);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=1; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 2; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,6);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1100788321U));
  ssSetChecksum1(S,(3595000294U));
  ssSetChecksum2(S,(2496414182U));
  ssSetChecksum3(S,(2251258883U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c6_Adaptive_Output_Regulator(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c6_Adaptive_Output_Regulator(SimStruct *S)
{
  SFc6_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc6_Adaptive_Output_RegulatorInstanceStruct *)utMalloc
    (sizeof(SFc6_Adaptive_Output_RegulatorInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc6_Adaptive_Output_RegulatorInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.mdlStart = mdlStart_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c6_Adaptive_Output_Regulator;
  chartInstance->chartInfo.callGetHoverDataForMsg = NULL;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.debugInstance = sfGlobalDebugInstanceStruct;
  chartInstance->S = S;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  chart_debug_initialization(S,1);
  mdl_start_c6_Adaptive_Output_Regulator(chartInstance);
}

void c6_Adaptive_Output_Regulator_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c6_Adaptive_Output_Regulator(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c6_Adaptive_Output_Regulator(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c6_Adaptive_Output_Regulator(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c6_Adaptive_Output_Regulator_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
