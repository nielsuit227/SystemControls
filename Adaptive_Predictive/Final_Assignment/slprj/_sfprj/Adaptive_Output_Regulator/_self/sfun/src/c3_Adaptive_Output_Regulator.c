/* Include files */

#include "Adaptive_Output_Regulator_sfun.h"
#include "c3_Adaptive_Output_Regulator.h"
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
static const char * c3_debug_family_names[12] = { "Sc", "Sr", "I_ni", "I_q",
  "sysmatrix", "nargin", "nargout", "S", "B", "A", "Q_T", "Q" };

/* Function Declarations */
static void initialize_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void initialize_params_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void enable_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void disable_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void c3_update_debugger_state_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void set_sim_state_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_st);
static void finalize_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void sf_gateway_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void mdl_start_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void initSimStructsc3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c3_machineNumber, uint32_T
  c3_chartNumber, uint32_T c3_instanceNumber);
static const mxArray *c3_sf_marshallOut(void *chartInstanceVoid, void *c3_inData);
static void c3_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_b_Q, const char_T *c3_identifier, real_T
  c3_y[144]);
static void c3_b_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId,
  real_T c3_y[144]);
static void c3_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData);
static const mxArray *c3_b_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static const mxArray *c3_c_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static const mxArray *c3_d_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static const mxArray *c3_e_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static real_T c3_c_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void c3_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData);
static const mxArray *c3_f_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static void c3_d_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId,
  real_T c3_y[9]);
static void c3_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData);
static void c3_kron(SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance,
                    real_T c3_b_A[16], real_T c3_b_B[9], real_T c3_K[144]);
static const mxArray *c3_g_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData);
static int32_T c3_e_emlrt_marshallIn
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void c3_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData);
static uint8_T c3_f_emlrt_marshallIn
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_b_is_active_c3_Adaptive_Output_Regulator, const char_T *c3_identifier);
static uint8_T c3_g_emlrt_marshallIn
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void init_dsm_address_info(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc3_Adaptive_Output_Regulator(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c3_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c3_is_active_c3_Adaptive_Output_Regulator = 0U;
}

static void initialize_params_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c3_update_debugger_state_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  const mxArray *c3_st;
  const mxArray *c3_y = NULL;
  const mxArray *c3_b_y = NULL;
  const mxArray *c3_c_y = NULL;
  uint8_T c3_hoistedGlobal;
  const mxArray *c3_d_y = NULL;
  c3_st = NULL;
  c3_st = NULL;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_createcellmatrix(3, 1), false);
  c3_b_y = NULL;
  sf_mex_assign(&c3_b_y, sf_mex_create("y", *chartInstance->c3_Q, 0, 0U, 1U, 0U,
    2, 12, 12), false);
  sf_mex_setcell(c3_y, 0, c3_b_y);
  c3_c_y = NULL;
  sf_mex_assign(&c3_c_y, sf_mex_create("y", *chartInstance->c3_Q_T, 0, 0U, 1U,
    0U, 2, 12, 12), false);
  sf_mex_setcell(c3_y, 1, c3_c_y);
  c3_hoistedGlobal = chartInstance->c3_is_active_c3_Adaptive_Output_Regulator;
  c3_d_y = NULL;
  sf_mex_assign(&c3_d_y, sf_mex_create("y", &c3_hoistedGlobal, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c3_y, 2, c3_d_y);
  sf_mex_assign(&c3_st, c3_y, false);
  return c3_st;
}

static void set_sim_state_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_st)
{
  const mxArray *c3_u;
  real_T c3_dv0[144];
  int32_T c3_i0;
  real_T c3_dv1[144];
  int32_T c3_i1;
  chartInstance->c3_doneDoubleBufferReInit = true;
  c3_u = sf_mex_dup(c3_st);
  c3_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell("Q", c3_u, 0)),
                      "Q", c3_dv0);
  for (c3_i0 = 0; c3_i0 < 144; c3_i0++) {
    (*chartInstance->c3_Q)[c3_i0] = c3_dv0[c3_i0];
  }

  c3_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell("Q_T", c3_u, 1)),
                      "Q_T", c3_dv1);
  for (c3_i1 = 0; c3_i1 < 144; c3_i1++) {
    (*chartInstance->c3_Q_T)[c3_i1] = c3_dv1[c3_i1];
  }

  chartInstance->c3_is_active_c3_Adaptive_Output_Regulator =
    c3_f_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(
    "is_active_c3_Adaptive_Output_Regulator", c3_u, 2)),
    "is_active_c3_Adaptive_Output_Regulator");
  sf_mex_destroy(&c3_u);
  c3_update_debugger_state_c3_Adaptive_Output_Regulator(chartInstance);
  sf_mex_destroy(&c3_st);
}

static void finalize_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  int32_T c3_i2;
  int32_T c3_i3;
  int32_T c3_i4;
  int32_T c3_i5;
  int32_T c3_i6;
  real_T c3_b_S[16];
  int32_T c3_i7;
  real_T c3_b_B[2];
  uint32_T c3_debug_family_var_map[12];
  real_T c3_b_A[4];
  real_T c3_Sc;
  real_T c3_Sr;
  real_T c3_I_ni[9];
  real_T c3_I_q[16];
  real_T c3_sysmatrix[9];
  real_T c3_nargin = 3.0;
  real_T c3_nargout = 2.0;
  real_T c3_b_Q_T[144];
  real_T c3_b_Q[144];
  int32_T c3_i8;
  static real_T c3_dv2[9] = { 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0 };

  int32_T c3_i9;
  static real_T c3_dv3[16] = { 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0,
    1.0, 0.0, 0.0, 0.0, 0.0, 1.0 };

  int32_T c3_i10;
  int32_T c3_i11;
  int32_T c3_i12;
  int32_T c3_i13;
  int32_T c3_i14;
  int32_T c3_i15;
  int32_T c3_i16;
  static real_T c3_dv4[3] = { 1.0, 0.0, 0.0 };

  int32_T c3_i17;
  int32_T c3_i18;
  int32_T c3_i19;
  int32_T c3_i20;
  int32_T c3_i21;
  real_T c3_c_S[16];
  real_T c3_dv5[9];
  real_T c3_dv6[144];
  int32_T c3_i22;
  int32_T c3_i23;
  real_T c3_dv7[16];
  real_T c3_b_sysmatrix[9];
  real_T c3_dv8[144];
  int32_T c3_i24;
  int32_T c3_i25;
  int32_T c3_i26;
  int32_T c3_i27;
  int32_T c3_i28;
  int32_T c3_i29;
  int32_T c3_i30;
  int32_T c3_i31;
  int32_T c3_i32;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c3_sfEvent);
  for (c3_i2 = 0; c3_i2 < 4; c3_i2++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c3_A)[c3_i2], 2U, 1U, 0U,
                          chartInstance->c3_sfEvent, false);
  }

  for (c3_i3 = 0; c3_i3 < 2; c3_i3++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c3_B)[c3_i3], 1U, 1U, 0U,
                          chartInstance->c3_sfEvent, false);
  }

  for (c3_i4 = 0; c3_i4 < 16; c3_i4++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c3_S)[c3_i4], 0U, 1U, 0U,
                          chartInstance->c3_sfEvent, false);
  }

  chartInstance->c3_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c3_sfEvent);
  for (c3_i5 = 0; c3_i5 < 16; c3_i5++) {
    c3_b_S[c3_i5] = (*chartInstance->c3_S)[c3_i5];
  }

  for (c3_i6 = 0; c3_i6 < 2; c3_i6++) {
    c3_b_B[c3_i6] = (*chartInstance->c3_B)[c3_i6];
  }

  for (c3_i7 = 0; c3_i7 < 4; c3_i7++) {
    c3_b_A[c3_i7] = (*chartInstance->c3_A)[c3_i7];
  }

  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 12U, 12U, c3_debug_family_names,
    c3_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c3_Sc, 0U, c3_e_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c3_Sr, 1U, c3_e_sf_marshallOut,
    c3_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c3_I_ni, 2U, c3_f_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c3_I_q, 3U, c3_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c3_sysmatrix, 4U, c3_f_sf_marshallOut,
    c3_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c3_nargin, 5U, c3_e_sf_marshallOut,
    c3_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c3_nargout, 6U, c3_e_sf_marshallOut,
    c3_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c3_b_S, 7U, c3_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c3_b_B, 8U, c3_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c3_b_A, 9U, c3_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c3_b_Q_T, 10U, c3_sf_marshallOut,
    c3_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c3_b_Q, 11U, c3_sf_marshallOut,
    c3_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, 2);
  c3_Sc = 4.0;
  c3_Sr = 4.0;
  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, 3);
  for (c3_i8 = 0; c3_i8 < 9; c3_i8++) {
    c3_I_ni[c3_i8] = c3_dv2[c3_i8];
  }

  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, 4);
  for (c3_i9 = 0; c3_i9 < 16; c3_i9++) {
    c3_I_q[c3_i9] = c3_dv3[c3_i9];
  }

  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, 5);
  c3_i10 = 0;
  c3_i11 = 0;
  for (c3_i12 = 0; c3_i12 < 2; c3_i12++) {
    for (c3_i14 = 0; c3_i14 < 2; c3_i14++) {
      c3_sysmatrix[c3_i14 + c3_i10] = c3_b_A[c3_i14 + c3_i11];
    }

    c3_i10 += 3;
    c3_i11 += 2;
  }

  for (c3_i13 = 0; c3_i13 < 2; c3_i13++) {
    c3_sysmatrix[c3_i13 + 6] = c3_b_B[c3_i13];
  }

  c3_i15 = 0;
  for (c3_i16 = 0; c3_i16 < 3; c3_i16++) {
    c3_sysmatrix[c3_i15 + 2] = c3_dv4[c3_i16];
    c3_i15 += 3;
  }

  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, 7);
  c3_i17 = 0;
  for (c3_i18 = 0; c3_i18 < 4; c3_i18++) {
    c3_i20 = 0;
    for (c3_i21 = 0; c3_i21 < 4; c3_i21++) {
      c3_c_S[c3_i21 + c3_i17] = c3_b_S[c3_i20 + c3_i18];
      c3_i20 += 4;
    }

    c3_i17 += 4;
  }

  for (c3_i19 = 0; c3_i19 < 9; c3_i19++) {
    c3_dv5[c3_i19] = c3_dv2[c3_i19];
  }

  c3_kron(chartInstance, c3_c_S, c3_dv5, c3_dv6);
  for (c3_i22 = 0; c3_i22 < 16; c3_i22++) {
    c3_dv7[c3_i22] = c3_dv3[c3_i22];
  }

  for (c3_i23 = 0; c3_i23 < 9; c3_i23++) {
    c3_b_sysmatrix[c3_i23] = c3_sysmatrix[c3_i23];
  }

  c3_kron(chartInstance, c3_dv7, c3_b_sysmatrix, c3_dv8);
  for (c3_i24 = 0; c3_i24 < 144; c3_i24++) {
    c3_b_Q[c3_i24] = c3_dv6[c3_i24] - c3_dv8[c3_i24];
  }

  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, 8);
  c3_i25 = 0;
  for (c3_i26 = 0; c3_i26 < 12; c3_i26++) {
    c3_i27 = 0;
    for (c3_i28 = 0; c3_i28 < 12; c3_i28++) {
      c3_b_Q_T[c3_i28 + c3_i25] = c3_b_Q[c3_i27 + c3_i26];
      c3_i27 += 12;
    }

    c3_i25 += 12;
  }

  _SFD_EML_CALL(0U, chartInstance->c3_sfEvent, -8);
  _SFD_SYMBOL_SCOPE_POP();
  for (c3_i29 = 0; c3_i29 < 144; c3_i29++) {
    (*chartInstance->c3_Q_T)[c3_i29] = c3_b_Q_T[c3_i29];
  }

  for (c3_i30 = 0; c3_i30 < 144; c3_i30++) {
    (*chartInstance->c3_Q)[c3_i30] = c3_b_Q[c3_i30];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c3_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_Adaptive_Output_RegulatorMachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
  for (c3_i31 = 0; c3_i31 < 144; c3_i31++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c3_Q_T)[c3_i31], 3U, 1U, 0U,
                          chartInstance->c3_sfEvent, false);
  }

  for (c3_i32 = 0; c3_i32 < 144; c3_i32++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c3_Q)[c3_i32], 4U, 1U, 0U,
                          chartInstance->c3_sfEvent, false);
  }
}

static void mdl_start_c3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void initSimStructsc3_Adaptive_Output_Regulator
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c3_machineNumber, uint32_T
  c3_chartNumber, uint32_T c3_instanceNumber)
{
  (void)c3_machineNumber;
  (void)c3_chartNumber;
  (void)c3_instanceNumber;
}

static const mxArray *c3_sf_marshallOut(void *chartInstanceVoid, void *c3_inData)
{
  const mxArray *c3_mxArrayOutData;
  int32_T c3_i33;
  int32_T c3_i34;
  const mxArray *c3_y = NULL;
  int32_T c3_i35;
  real_T c3_u[144];
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_mxArrayOutData = NULL;
  c3_i33 = 0;
  for (c3_i34 = 0; c3_i34 < 12; c3_i34++) {
    for (c3_i35 = 0; c3_i35 < 12; c3_i35++) {
      c3_u[c3_i35 + c3_i33] = (*(real_T (*)[144])c3_inData)[c3_i35 + c3_i33];
    }

    c3_i33 += 12;
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 2, 12, 12), false);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, false);
  return c3_mxArrayOutData;
}

static void c3_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_b_Q, const char_T *c3_identifier, real_T
  c3_y[144])
{
  emlrtMsgIdentifier c3_thisId;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_thisId.bParentIsCell = false;
  c3_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_b_Q), &c3_thisId, c3_y);
  sf_mex_destroy(&c3_b_Q);
}

static void c3_b_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId,
  real_T c3_y[144])
{
  real_T c3_dv9[144];
  int32_T c3_i36;
  (void)chartInstance;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), c3_dv9, 1, 0, 0U, 1, 0U, 2, 12,
                12);
  for (c3_i36 = 0; c3_i36 < 144; c3_i36++) {
    c3_y[c3_i36] = c3_dv9[c3_i36];
  }

  sf_mex_destroy(&c3_u);
}

static void c3_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData)
{
  const mxArray *c3_b_Q;
  const char_T *c3_identifier;
  emlrtMsgIdentifier c3_thisId;
  real_T c3_y[144];
  int32_T c3_i37;
  int32_T c3_i38;
  int32_T c3_i39;
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_b_Q = sf_mex_dup(c3_mxArrayInData);
  c3_identifier = c3_varName;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_thisId.bParentIsCell = false;
  c3_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_b_Q), &c3_thisId, c3_y);
  sf_mex_destroy(&c3_b_Q);
  c3_i37 = 0;
  for (c3_i38 = 0; c3_i38 < 12; c3_i38++) {
    for (c3_i39 = 0; c3_i39 < 12; c3_i39++) {
      (*(real_T (*)[144])c3_outData)[c3_i39 + c3_i37] = c3_y[c3_i39 + c3_i37];
    }

    c3_i37 += 12;
  }

  sf_mex_destroy(&c3_mxArrayInData);
}

static const mxArray *c3_b_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData;
  int32_T c3_i40;
  int32_T c3_i41;
  const mxArray *c3_y = NULL;
  int32_T c3_i42;
  real_T c3_u[4];
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_mxArrayOutData = NULL;
  c3_i40 = 0;
  for (c3_i41 = 0; c3_i41 < 2; c3_i41++) {
    for (c3_i42 = 0; c3_i42 < 2; c3_i42++) {
      c3_u[c3_i42 + c3_i40] = (*(real_T (*)[4])c3_inData)[c3_i42 + c3_i40];
    }

    c3_i40 += 2;
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 2, 2, 2), false);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, false);
  return c3_mxArrayOutData;
}

static const mxArray *c3_c_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData;
  int32_T c3_i43;
  const mxArray *c3_y = NULL;
  real_T c3_u[2];
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_mxArrayOutData = NULL;
  for (c3_i43 = 0; c3_i43 < 2; c3_i43++) {
    c3_u[c3_i43] = (*(real_T (*)[2])c3_inData)[c3_i43];
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 2, 2, 1), false);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, false);
  return c3_mxArrayOutData;
}

static const mxArray *c3_d_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData;
  int32_T c3_i44;
  int32_T c3_i45;
  const mxArray *c3_y = NULL;
  int32_T c3_i46;
  real_T c3_u[16];
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_mxArrayOutData = NULL;
  c3_i44 = 0;
  for (c3_i45 = 0; c3_i45 < 4; c3_i45++) {
    for (c3_i46 = 0; c3_i46 < 4; c3_i46++) {
      c3_u[c3_i46 + c3_i44] = (*(real_T (*)[16])c3_inData)[c3_i46 + c3_i44];
    }

    c3_i44 += 4;
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 2, 4, 4), false);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, false);
  return c3_mxArrayOutData;
}

static const mxArray *c3_e_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData;
  real_T c3_u;
  const mxArray *c3_y = NULL;
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_mxArrayOutData = NULL;
  c3_u = *(real_T *)c3_inData;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", &c3_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, false);
  return c3_mxArrayOutData;
}

static real_T c3_c_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  real_T c3_y;
  real_T c3_d0;
  (void)chartInstance;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_d0, 1, 0, 0U, 0, 0U, 0);
  c3_y = c3_d0;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void c3_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData)
{
  const mxArray *c3_nargout;
  const char_T *c3_identifier;
  emlrtMsgIdentifier c3_thisId;
  real_T c3_y;
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_nargout = sf_mex_dup(c3_mxArrayInData);
  c3_identifier = c3_varName;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_thisId.bParentIsCell = false;
  c3_y = c3_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_nargout), &c3_thisId);
  sf_mex_destroy(&c3_nargout);
  *(real_T *)c3_outData = c3_y;
  sf_mex_destroy(&c3_mxArrayInData);
}

static const mxArray *c3_f_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData;
  int32_T c3_i47;
  int32_T c3_i48;
  const mxArray *c3_y = NULL;
  int32_T c3_i49;
  real_T c3_u[9];
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_mxArrayOutData = NULL;
  c3_i47 = 0;
  for (c3_i48 = 0; c3_i48 < 3; c3_i48++) {
    for (c3_i49 = 0; c3_i49 < 3; c3_i49++) {
      c3_u[c3_i49 + c3_i47] = (*(real_T (*)[9])c3_inData)[c3_i49 + c3_i47];
    }

    c3_i47 += 3;
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 0, 0U, 1U, 0U, 2, 3, 3), false);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, false);
  return c3_mxArrayOutData;
}

static void c3_d_emlrt_marshallIn(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId,
  real_T c3_y[9])
{
  real_T c3_dv10[9];
  int32_T c3_i50;
  (void)chartInstance;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), c3_dv10, 1, 0, 0U, 1, 0U, 2, 3, 3);
  for (c3_i50 = 0; c3_i50 < 9; c3_i50++) {
    c3_y[c3_i50] = c3_dv10[c3_i50];
  }

  sf_mex_destroy(&c3_u);
}

static void c3_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData)
{
  const mxArray *c3_sysmatrix;
  const char_T *c3_identifier;
  emlrtMsgIdentifier c3_thisId;
  real_T c3_y[9];
  int32_T c3_i51;
  int32_T c3_i52;
  int32_T c3_i53;
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_sysmatrix = sf_mex_dup(c3_mxArrayInData);
  c3_identifier = c3_varName;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_thisId.bParentIsCell = false;
  c3_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_sysmatrix), &c3_thisId,
                        c3_y);
  sf_mex_destroy(&c3_sysmatrix);
  c3_i51 = 0;
  for (c3_i52 = 0; c3_i52 < 3; c3_i52++) {
    for (c3_i53 = 0; c3_i53 < 3; c3_i53++) {
      (*(real_T (*)[9])c3_outData)[c3_i53 + c3_i51] = c3_y[c3_i53 + c3_i51];
    }

    c3_i51 += 3;
  }

  sf_mex_destroy(&c3_mxArrayInData);
}

const mxArray *sf_c3_Adaptive_Output_Regulator_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c3_nameCaptureInfo = NULL;
  c3_nameCaptureInfo = NULL;
  sf_mex_assign(&c3_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c3_nameCaptureInfo;
}

static void c3_kron(SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance,
                    real_T c3_b_A[16], real_T c3_b_B[9], real_T c3_K[144])
{
  int32_T c3_kidx;
  int32_T c3_j1;
  int32_T c3_j2;
  int32_T c3_i1;
  int32_T c3_i2;
  int32_T c3_a;
  (void)chartInstance;
  c3_kidx = -1;
  for (c3_j1 = 0; c3_j1 + 1 < 5; c3_j1++) {
    for (c3_j2 = 0; c3_j2 + 1 < 4; c3_j2++) {
      for (c3_i1 = 0; c3_i1 + 1 < 5; c3_i1++) {
        for (c3_i2 = 0; c3_i2 + 1 < 4; c3_i2++) {
          c3_a = c3_kidx + 1;
          c3_kidx = c3_a;
          c3_K[c3_kidx] = c3_b_A[c3_i1 + (c3_j1 << 2)] * c3_b_B[c3_i2 + 3 *
            c3_j2];
        }
      }
    }
  }
}

static const mxArray *c3_g_sf_marshallOut(void *chartInstanceVoid, void
  *c3_inData)
{
  const mxArray *c3_mxArrayOutData;
  int32_T c3_u;
  const mxArray *c3_y = NULL;
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_mxArrayOutData = NULL;
  c3_mxArrayOutData = NULL;
  c3_u = *(int32_T *)c3_inData;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", &c3_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c3_mxArrayOutData, c3_y, false);
  return c3_mxArrayOutData;
}

static int32_T c3_e_emlrt_marshallIn
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  int32_T c3_y;
  int32_T c3_i54;
  (void)chartInstance;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_i54, 1, 6, 0U, 0, 0U, 0);
  c3_y = c3_i54;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void c3_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c3_mxArrayInData, const char_T *c3_varName, void *c3_outData)
{
  const mxArray *c3_b_sfEvent;
  const char_T *c3_identifier;
  emlrtMsgIdentifier c3_thisId;
  int32_T c3_y;
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)
    chartInstanceVoid;
  c3_b_sfEvent = sf_mex_dup(c3_mxArrayInData);
  c3_identifier = c3_varName;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_thisId.bParentIsCell = false;
  c3_y = c3_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_b_sfEvent),
    &c3_thisId);
  sf_mex_destroy(&c3_b_sfEvent);
  *(int32_T *)c3_outData = c3_y;
  sf_mex_destroy(&c3_mxArrayInData);
}

static uint8_T c3_f_emlrt_marshallIn
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_b_is_active_c3_Adaptive_Output_Regulator, const char_T *c3_identifier)
{
  uint8_T c3_y;
  emlrtMsgIdentifier c3_thisId;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_thisId.bParentIsCell = false;
  c3_y = c3_g_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c3_b_is_active_c3_Adaptive_Output_Regulator), &c3_thisId);
  sf_mex_destroy(&c3_b_is_active_c3_Adaptive_Output_Regulator);
  return c3_y;
}

static uint8_T c3_g_emlrt_marshallIn
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance, const mxArray
   *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  uint8_T c3_y;
  uint8_T c3_u0;
  (void)chartInstance;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_u0, 1, 3, 0U, 0, 0U, 0);
  c3_y = c3_u0;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void init_dsm_address_info(SFc3_Adaptive_Output_RegulatorInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance)
{
  chartInstance->c3_Q_T = (real_T (*)[144])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c3_Q = (real_T (*)[144])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c3_S = (real_T (*)[16])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c3_B = (real_T (*)[2])ssGetInputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c3_A = (real_T (*)[4])ssGetInputPortSignal_wrapper
    (chartInstance->S, 2);
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

void sf_c3_Adaptive_Output_Regulator_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3525571525U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(101102965U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1125660754U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(4045706794U);
}

mxArray* sf_c3_Adaptive_Output_Regulator_get_post_codegen_info(void);
mxArray *sf_c3_Adaptive_Output_Regulator_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("yIGLrNBBB6xrjn6b68o7hE");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,3,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(4);
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
      pr[0] = (double)(2);
      pr[1] = (double)(1);
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

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(2);
      pr[1] = (double)(2);
      mxSetField(mxData,2,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,2,"type",mxType);
    }

    mxSetField(mxData,2,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(12);
      pr[1] = (double)(12);
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
      pr[0] = (double)(12);
      pr[1] = (double)(12);
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
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxArray* mxPostCodegenInfo =
      sf_c3_Adaptive_Output_Regulator_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c3_Adaptive_Output_Regulator_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c3_Adaptive_Output_Regulator_jit_fallback_info(void)
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

mxArray *sf_c3_Adaptive_Output_Regulator_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c3_Adaptive_Output_Regulator_get_post_codegen_info(void)
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

static const mxArray *sf_get_sim_state_info_c3_Adaptive_Output_Regulator(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x3'type','srcId','name','auxInfo'{{M[1],M[5],T\"Q\",},{M[1],M[6],T\"Q_T\",},{M[8],M[0],T\"is_active_c3_Adaptive_Output_Regulator\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 3, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c3_Adaptive_Output_Regulator_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance =
      (SFc3_Adaptive_Output_RegulatorInstanceStruct *)sf_get_chart_instance_ptr
      (S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _Adaptive_Output_RegulatorMachineNumber_,
           3,
           1,
           1,
           0,
           5,
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
          _SFD_SET_DATA_PROPS(0,1,1,0,"S");
          _SFD_SET_DATA_PROPS(1,1,1,0,"B");
          _SFD_SET_DATA_PROPS(2,1,1,0,"A");
          _SFD_SET_DATA_PROPS(3,2,0,1,"Q_T");
          _SFD_SET_DATA_PROPS(4,2,0,1,"Q");
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
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,180);

        {
          unsigned int dimVector[2];
          dimVector[0]= 4U;
          dimVector[1]= 4U;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c3_d_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 2U;
          dimVector[1]= 1U;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c3_c_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 2U;
          dimVector[1]= 2U;
          _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c3_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 12U;
          dimVector[1]= 12U;
          _SFD_SET_DATA_COMPILED_PROPS(3,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c3_sf_marshallOut,(MexInFcnForType)
            c3_sf_marshallIn);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 12U;
          dimVector[1]= 12U;
          _SFD_SET_DATA_COMPILED_PROPS(4,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c3_sf_marshallOut,(MexInFcnForType)
            c3_sf_marshallIn);
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
    SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance =
      (SFc3_Adaptive_Output_RegulatorInstanceStruct *)sf_get_chart_instance_ptr
      (S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(3U, *chartInstance->c3_Q_T);
        _SFD_SET_DATA_VALUE_PTR(4U, *chartInstance->c3_Q);
        _SFD_SET_DATA_VALUE_PTR(0U, *chartInstance->c3_S);
        _SFD_SET_DATA_VALUE_PTR(1U, *chartInstance->c3_B);
        _SFD_SET_DATA_VALUE_PTR(2U, *chartInstance->c3_A);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "suRiQvpQyu4f2ynwj9q6mu";
}

static void sf_opaque_initialize_c3_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  chart_debug_initialization(((SFc3_Adaptive_Output_RegulatorInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
  initialize_c3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c3_Adaptive_Output_Regulator(void *chartInstanceVar)
{
  enable_c3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c3_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  disable_c3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c3_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  sf_gateway_c3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c3_Adaptive_Output_Regulator
  (SimStruct* S)
{
  return get_sim_state_c3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct *)sf_get_chart_instance_ptr(S));/* raw sim ctx */
}

static void sf_opaque_set_sim_state_c3_Adaptive_Output_Regulator(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct*)sf_get_chart_instance_ptr(S),
     st);
}

static void sf_opaque_terminate_c3_Adaptive_Output_Regulator(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc3_Adaptive_Output_RegulatorInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Adaptive_Output_Regulator_optimization_info();
    }

    finalize_c3_Adaptive_Output_Regulator
      ((SFc3_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc3_Adaptive_Output_Regulator
    ((SFc3_Adaptive_Output_RegulatorInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c3_Adaptive_Output_Regulator(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c3_Adaptive_Output_Regulator
      ((SFc3_Adaptive_Output_RegulatorInstanceStruct*)sf_get_chart_instance_ptr
       (S));
  }
}

static void mdlSetWorkWidths_c3_Adaptive_Output_Regulator(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetStatesModifiedOnlyInUpdate(S, 1);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_Adaptive_Output_Regulator_optimization_info
      (sim_mode_is_rtw_gen(S), sim_mode_is_modelref_sim(S), sim_mode_is_external
       (S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,3);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,3,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 3);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,3);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,3,3);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,3,2);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=2; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 3; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,3);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1274633009U));
  ssSetChecksum1(S,(882839845U));
  ssSetChecksum2(S,(2705060004U));
  ssSetChecksum3(S,(1240151375U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c3_Adaptive_Output_Regulator(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c3_Adaptive_Output_Regulator(SimStruct *S)
{
  SFc3_Adaptive_Output_RegulatorInstanceStruct *chartInstance;
  chartInstance = (SFc3_Adaptive_Output_RegulatorInstanceStruct *)utMalloc
    (sizeof(SFc3_Adaptive_Output_RegulatorInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc3_Adaptive_Output_RegulatorInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.mdlStart = mdlStart_c3_Adaptive_Output_Regulator;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c3_Adaptive_Output_Regulator;
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
  mdl_start_c3_Adaptive_Output_Regulator(chartInstance);
}

void c3_Adaptive_Output_Regulator_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c3_Adaptive_Output_Regulator(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c3_Adaptive_Output_Regulator(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c3_Adaptive_Output_Regulator(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c3_Adaptive_Output_Regulator_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
