/* Include files */

#include "Regulator_Solver_2016_sfun.h"
#include "c2_Regulator_Solver_2016.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "Regulator_Solver_2016_sfun_debug_macros.h"
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
static const char * c2_debug_family_names[12] = { "I_ni", "I_q", "sysmatrix",
  "nargin", "nargout", "S", "D", "C", "B", "A", "Q_T", "Q" };

/* Function Declarations */
static void initialize_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void initialize_params_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void enable_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void disable_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void c2_update_debugger_state_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void set_sim_state_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance, const mxArray *c2_st);
static void finalize_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void sf_gateway_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void mdl_start_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void initSimStructsc2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber);
static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData);
static void c2_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_b_Q, const char_T *c2_identifier, real_T
  c2_y[36]);
static void c2_b_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[36]);
static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static real_T c2_c_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_f_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_d_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[9]);
static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static void c2_kron(SFc2_Regulator_Solver_2016InstanceStruct *chartInstance,
                    real_T c2_b_A[4], real_T c2_b_B[9], real_T c2_K[36]);
static const mxArray *c2_g_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static int32_T c2_e_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static uint8_T c2_f_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_Regulator_Solver_2016, const
  char_T *c2_identifier);
static uint8_T c2_g_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance);

/* Function Definitions */
static void initialize_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc2_Regulator_Solver_2016(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c2_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c2_is_active_c2_Regulator_Solver_2016 = 0U;
}

static void initialize_params_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c2_update_debugger_state_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  const mxArray *c2_b_y = NULL;
  const mxArray *c2_c_y = NULL;
  uint8_T c2_hoistedGlobal;
  const mxArray *c2_d_y = NULL;
  c2_st = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellmatrix(3, 1), false);
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", *chartInstance->c2_Q, 0, 0U, 1U, 0U,
    2, 6, 6), false);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", *chartInstance->c2_Q_T, 0, 0U, 1U,
    0U, 2, 6, 6), false);
  sf_mex_setcell(c2_y, 1, c2_c_y);
  c2_hoistedGlobal = chartInstance->c2_is_active_c2_Regulator_Solver_2016;
  c2_d_y = NULL;
  sf_mex_assign(&c2_d_y, sf_mex_create("y", &c2_hoistedGlobal, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c2_y, 2, c2_d_y);
  sf_mex_assign(&c2_st, c2_y, false);
  return c2_st;
}

static void set_sim_state_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance, const mxArray *c2_st)
{
  const mxArray *c2_u;
  real_T c2_dv0[36];
  int32_T c2_i0;
  real_T c2_dv1[36];
  int32_T c2_i1;
  chartInstance->c2_doneDoubleBufferReInit = true;
  c2_u = sf_mex_dup(c2_st);
  c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell("Q", c2_u, 0)),
                      "Q", c2_dv0);
  for (c2_i0 = 0; c2_i0 < 36; c2_i0++) {
    (*chartInstance->c2_Q)[c2_i0] = c2_dv0[c2_i0];
  }

  c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell("Q_T", c2_u, 1)),
                      "Q_T", c2_dv1);
  for (c2_i1 = 0; c2_i1 < 36; c2_i1++) {
    (*chartInstance->c2_Q_T)[c2_i1] = c2_dv1[c2_i1];
  }

  chartInstance->c2_is_active_c2_Regulator_Solver_2016 = c2_f_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(
       "is_active_c2_Regulator_Solver_2016", c2_u, 2)),
     "is_active_c2_Regulator_Solver_2016");
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_Regulator_Solver_2016(chartInstance);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  int32_T c2_i2;
  int32_T c2_i3;
  int32_T c2_i4;
  int32_T c2_i5;
  real_T c2_hoistedGlobal;
  int32_T c2_i6;
  real_T c2_b_D;
  real_T c2_b_S[4];
  int32_T c2_i7;
  int32_T c2_i8;
  real_T c2_b_C[2];
  int32_T c2_i9;
  real_T c2_b_B[2];
  uint32_T c2_debug_family_var_map[12];
  real_T c2_b_A[4];
  real_T c2_I_ni[9];
  real_T c2_I_q[4];
  real_T c2_sysmatrix[9];
  real_T c2_nargin = 5.0;
  real_T c2_nargout = 2.0;
  real_T c2_b_Q_T[36];
  real_T c2_b_Q[36];
  int32_T c2_i10;
  static real_T c2_dv2[9] = { 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0 };

  int32_T c2_i11;
  static real_T c2_dv3[4] = { 1.0, 0.0, 0.0, 1.0 };

  int32_T c2_i12;
  int32_T c2_i13;
  int32_T c2_i14;
  int32_T c2_i15;
  int32_T c2_i16;
  int32_T c2_i17;
  int32_T c2_i18;
  int32_T c2_i19;
  int32_T c2_i20;
  int32_T c2_i21;
  int32_T c2_i22;
  int32_T c2_i23;
  real_T c2_c_S[4];
  real_T c2_dv4[9];
  real_T c2_dv5[36];
  int32_T c2_i24;
  int32_T c2_i25;
  real_T c2_dv6[4];
  real_T c2_b_sysmatrix[9];
  real_T c2_dv7[36];
  int32_T c2_i26;
  int32_T c2_i27;
  int32_T c2_i28;
  int32_T c2_i29;
  int32_T c2_i30;
  int32_T c2_i31;
  int32_T c2_i32;
  int32_T c2_i33;
  int32_T c2_i34;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  for (c2_i2 = 0; c2_i2 < 4; c2_i2++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c2_A)[c2_i2], 4U, 1U, 0U,
                          chartInstance->c2_sfEvent, false);
  }

  for (c2_i3 = 0; c2_i3 < 2; c2_i3++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c2_B)[c2_i3], 3U, 1U, 0U,
                          chartInstance->c2_sfEvent, false);
  }

  for (c2_i4 = 0; c2_i4 < 2; c2_i4++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c2_C)[c2_i4], 2U, 1U, 0U,
                          chartInstance->c2_sfEvent, false);
  }

  _SFD_DATA_RANGE_CHECK(*chartInstance->c2_D, 1U, 1U, 0U,
                        chartInstance->c2_sfEvent, false);
  for (c2_i5 = 0; c2_i5 < 4; c2_i5++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c2_S)[c2_i5], 0U, 1U, 0U,
                          chartInstance->c2_sfEvent, false);
  }

  chartInstance->c2_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  c2_hoistedGlobal = *chartInstance->c2_D;
  for (c2_i6 = 0; c2_i6 < 4; c2_i6++) {
    c2_b_S[c2_i6] = (*chartInstance->c2_S)[c2_i6];
  }

  c2_b_D = c2_hoistedGlobal;
  for (c2_i7 = 0; c2_i7 < 2; c2_i7++) {
    c2_b_C[c2_i7] = (*chartInstance->c2_C)[c2_i7];
  }

  for (c2_i8 = 0; c2_i8 < 2; c2_i8++) {
    c2_b_B[c2_i8] = (*chartInstance->c2_B)[c2_i8];
  }

  for (c2_i9 = 0; c2_i9 < 4; c2_i9++) {
    c2_b_A[c2_i9] = (*chartInstance->c2_A)[c2_i9];
  }

  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 12U, 12U, c2_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_I_ni, 0U, c2_f_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_I_q, 1U, c2_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_sysmatrix, 2U, c2_f_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 3U, c2_e_sf_marshallOut,
    c2_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 4U, c2_e_sf_marshallOut,
    c2_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_b_S, 5U, c2_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_b_D, 6U, c2_e_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_b_C, 7U, c2_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_b_B, 8U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_b_A, 9U, c2_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_b_Q_T, 10U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_b_Q, 11U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 3);
  for (c2_i10 = 0; c2_i10 < 9; c2_i10++) {
    c2_I_ni[c2_i10] = c2_dv2[c2_i10];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 4);
  for (c2_i11 = 0; c2_i11 < 4; c2_i11++) {
    c2_I_q[c2_i11] = c2_dv3[c2_i11];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 5);
  c2_i12 = 0;
  c2_i13 = 0;
  for (c2_i14 = 0; c2_i14 < 2; c2_i14++) {
    for (c2_i16 = 0; c2_i16 < 2; c2_i16++) {
      c2_sysmatrix[c2_i16 + c2_i12] = c2_b_A[c2_i16 + c2_i13];
    }

    c2_i12 += 3;
    c2_i13 += 2;
  }

  for (c2_i15 = 0; c2_i15 < 2; c2_i15++) {
    c2_sysmatrix[c2_i15 + 6] = c2_b_B[c2_i15];
  }

  c2_i17 = 0;
  for (c2_i18 = 0; c2_i18 < 2; c2_i18++) {
    c2_sysmatrix[c2_i17 + 2] = c2_b_C[c2_i18];
    c2_i17 += 3;
  }

  c2_sysmatrix[8] = c2_b_D;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 7);
  c2_i19 = 0;
  for (c2_i20 = 0; c2_i20 < 2; c2_i20++) {
    c2_i22 = 0;
    for (c2_i23 = 0; c2_i23 < 2; c2_i23++) {
      c2_c_S[c2_i23 + c2_i19] = c2_b_S[c2_i22 + c2_i20];
      c2_i22 += 2;
    }

    c2_i19 += 2;
  }

  for (c2_i21 = 0; c2_i21 < 9; c2_i21++) {
    c2_dv4[c2_i21] = c2_dv2[c2_i21];
  }

  c2_kron(chartInstance, c2_c_S, c2_dv4, c2_dv5);
  for (c2_i24 = 0; c2_i24 < 4; c2_i24++) {
    c2_dv6[c2_i24] = c2_dv3[c2_i24];
  }

  for (c2_i25 = 0; c2_i25 < 9; c2_i25++) {
    c2_b_sysmatrix[c2_i25] = c2_sysmatrix[c2_i25];
  }

  c2_kron(chartInstance, c2_dv6, c2_b_sysmatrix, c2_dv7);
  for (c2_i26 = 0; c2_i26 < 36; c2_i26++) {
    c2_b_Q[c2_i26] = c2_dv5[c2_i26] - c2_dv7[c2_i26];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 8);
  c2_i27 = 0;
  for (c2_i28 = 0; c2_i28 < 6; c2_i28++) {
    c2_i29 = 0;
    for (c2_i30 = 0; c2_i30 < 6; c2_i30++) {
      c2_b_Q_T[c2_i30 + c2_i27] = c2_b_Q[c2_i29 + c2_i28];
      c2_i29 += 6;
    }

    c2_i27 += 6;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, -8);
  _SFD_SYMBOL_SCOPE_POP();
  for (c2_i31 = 0; c2_i31 < 36; c2_i31++) {
    (*chartInstance->c2_Q_T)[c2_i31] = c2_b_Q_T[c2_i31];
  }

  for (c2_i32 = 0; c2_i32 < 36; c2_i32++) {
    (*chartInstance->c2_Q)[c2_i32] = c2_b_Q[c2_i32];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_Regulator_Solver_2016MachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
  for (c2_i33 = 0; c2_i33 < 36; c2_i33++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c2_Q_T)[c2_i33], 5U, 1U, 0U,
                          chartInstance->c2_sfEvent, false);
  }

  for (c2_i34 = 0; c2_i34 < 36; c2_i34++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c2_Q)[c2_i34], 6U, 1U, 0U,
                          chartInstance->c2_sfEvent, false);
  }
}

static void mdl_start_c2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void initSimStructsc2_Regulator_Solver_2016
  (SFc2_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber)
{
  (void)c2_machineNumber;
  (void)c2_chartNumber;
  (void)c2_instanceNumber;
}

static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_i35;
  int32_T c2_i36;
  const mxArray *c2_y = NULL;
  int32_T c2_i37;
  real_T c2_u[36];
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_i35 = 0;
  for (c2_i36 = 0; c2_i36 < 6; c2_i36++) {
    for (c2_i37 = 0; c2_i37 < 6; c2_i37++) {
      c2_u[c2_i37 + c2_i35] = (*(real_T (*)[36])c2_inData)[c2_i37 + c2_i35];
    }

    c2_i35 += 6;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 6, 6), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static void c2_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_b_Q, const char_T *c2_identifier, real_T
  c2_y[36])
{
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_Q), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_b_Q);
}

static void c2_b_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[36])
{
  real_T c2_dv8[36];
  int32_T c2_i38;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv8, 1, 0, 0U, 1, 0U, 2, 6, 6);
  for (c2_i38 = 0; c2_i38 < 36; c2_i38++) {
    c2_y[c2_i38] = c2_dv8[c2_i38];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_Q;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[36];
  int32_T c2_i39;
  int32_T c2_i40;
  int32_T c2_i41;
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_b_Q = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_Q), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_b_Q);
  c2_i39 = 0;
  for (c2_i40 = 0; c2_i40 < 6; c2_i40++) {
    for (c2_i41 = 0; c2_i41 < 6; c2_i41++) {
      (*(real_T (*)[36])c2_outData)[c2_i41 + c2_i39] = c2_y[c2_i41 + c2_i39];
    }

    c2_i39 += 6;
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_i42;
  int32_T c2_i43;
  const mxArray *c2_y = NULL;
  int32_T c2_i44;
  real_T c2_u[4];
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_i42 = 0;
  for (c2_i43 = 0; c2_i43 < 2; c2_i43++) {
    for (c2_i44 = 0; c2_i44 < 2; c2_i44++) {
      c2_u[c2_i44 + c2_i42] = (*(real_T (*)[4])c2_inData)[c2_i44 + c2_i42];
    }

    c2_i42 += 2;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 2, 2), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_i45;
  const mxArray *c2_y = NULL;
  real_T c2_u[2];
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  for (c2_i45 = 0; c2_i45 < 2; c2_i45++) {
    c2_u[c2_i45] = (*(real_T (*)[2])c2_inData)[c2_i45];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 2, 1), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_i46;
  const mxArray *c2_y = NULL;
  real_T c2_u[2];
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  for (c2_i46 = 0; c2_i46 < 2; c2_i46++) {
    c2_u[c2_i46] = (*(real_T (*)[2])c2_inData)[c2_i46];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 1, 2), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_u = *(real_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static real_T c2_c_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_nargout;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y;
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_nargout = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_nargout), &c2_thisId);
  sf_mex_destroy(&c2_nargout);
  *(real_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_f_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_i47;
  int32_T c2_i48;
  const mxArray *c2_y = NULL;
  int32_T c2_i49;
  real_T c2_u[9];
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_i47 = 0;
  for (c2_i48 = 0; c2_i48 < 3; c2_i48++) {
    for (c2_i49 = 0; c2_i49 < 3; c2_i49++) {
      c2_u[c2_i49 + c2_i47] = (*(real_T (*)[9])c2_inData)[c2_i49 + c2_i47];
    }

    c2_i47 += 3;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 3, 3), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static void c2_d_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId,
  real_T c2_y[9])
{
  real_T c2_dv9[9];
  int32_T c2_i50;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv9, 1, 0, 0U, 1, 0U, 2, 3, 3);
  for (c2_i50 = 0; c2_i50 < 9; c2_i50++) {
    c2_y[c2_i50] = c2_dv9[c2_i50];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_sysmatrix;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[9];
  int32_T c2_i51;
  int32_T c2_i52;
  int32_T c2_i53;
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_sysmatrix = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_sysmatrix), &c2_thisId,
                        c2_y);
  sf_mex_destroy(&c2_sysmatrix);
  c2_i51 = 0;
  for (c2_i52 = 0; c2_i52 < 3; c2_i52++) {
    for (c2_i53 = 0; c2_i53 < 3; c2_i53++) {
      (*(real_T (*)[9])c2_outData)[c2_i53 + c2_i51] = c2_y[c2_i53 + c2_i51];
    }

    c2_i51 += 3;
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

const mxArray *sf_c2_Regulator_Solver_2016_get_eml_resolved_functions_info(void)
{
  const mxArray *c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  sf_mex_assign(&c2_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c2_nameCaptureInfo;
}

static void c2_kron(SFc2_Regulator_Solver_2016InstanceStruct *chartInstance,
                    real_T c2_b_A[4], real_T c2_b_B[9], real_T c2_K[36])
{
  int32_T c2_kidx;
  int32_T c2_j1;
  int32_T c2_j2;
  int32_T c2_i1;
  int32_T c2_i2;
  int32_T c2_a;
  (void)chartInstance;
  c2_kidx = -1;
  for (c2_j1 = 0; c2_j1 + 1 < 3; c2_j1++) {
    for (c2_j2 = 0; c2_j2 + 1 < 4; c2_j2++) {
      for (c2_i1 = 0; c2_i1 + 1 < 3; c2_i1++) {
        for (c2_i2 = 0; c2_i2 + 1 < 4; c2_i2++) {
          c2_a = c2_kidx + 1;
          c2_kidx = c2_a;
          c2_K[c2_kidx] = c2_b_A[c2_i1 + (c2_j1 << 1)] * c2_b_B[c2_i2 + 3 *
            c2_j2];
        }
      }
    }
  }
}

static const mxArray *c2_g_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData;
  int32_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_mxArrayOutData = NULL;
  c2_u = *(int32_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static int32_T c2_e_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  int32_T c2_y;
  int32_T c2_i54;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_i54, 1, 6, 0U, 0, 0U, 0);
  c2_y = c2_i54;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_sfEvent;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_y;
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c2_b_sfEvent = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_sfEvent),
    &c2_thisId);
  sf_mex_destroy(&c2_b_sfEvent);
  *(int32_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static uint8_T c2_f_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_Regulator_Solver_2016, const
  char_T *c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_thisId.bParentIsCell = false;
  c2_y = c2_g_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_Regulator_Solver_2016), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_Regulator_Solver_2016);
  return c2_y;
}

static uint8_T c2_g_emlrt_marshallIn(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address(SFc2_Regulator_Solver_2016InstanceStruct
  *chartInstance)
{
  chartInstance->c2_Q_T = (real_T (*)[36])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c2_Q = (real_T (*)[36])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c2_S = (real_T (*)[4])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c2_D = (real_T *)ssGetInputPortSignal_wrapper(chartInstance->S,
    1);
  chartInstance->c2_C = (real_T (*)[2])ssGetInputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c2_B = (real_T (*)[2])ssGetInputPortSignal_wrapper
    (chartInstance->S, 3);
  chartInstance->c2_A = (real_T (*)[4])ssGetInputPortSignal_wrapper
    (chartInstance->S, 4);
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

void sf_c2_Regulator_Solver_2016_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1445576817U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(2141576552U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1647118152U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1629543756U);
}

mxArray* sf_c2_Regulator_Solver_2016_get_post_codegen_info(void);
mxArray *sf_c2_Regulator_Solver_2016_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("1OyngbX3T4aPevc5N1zvMH");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,5,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(2);
      pr[1] = (double)(2);
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
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
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
      pr[0] = (double)(1);
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

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(2);
      pr[1] = (double)(1);
      mxSetField(mxData,3,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,3,"type",mxType);
    }

    mxSetField(mxData,3,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(2);
      pr[1] = (double)(2);
      mxSetField(mxData,4,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,4,"type",mxType);
    }

    mxSetField(mxData,4,"complexity",mxCreateDoubleScalar(0));
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
      pr[0] = (double)(6);
      pr[1] = (double)(6);
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
      pr[0] = (double)(6);
      pr[1] = (double)(6);
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
      sf_c2_Regulator_Solver_2016_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c2_Regulator_Solver_2016_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c2_Regulator_Solver_2016_jit_fallback_info(void)
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

mxArray *sf_c2_Regulator_Solver_2016_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c2_Regulator_Solver_2016_get_post_codegen_info(void)
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

static const mxArray *sf_get_sim_state_info_c2_Regulator_Solver_2016(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x3'type','srcId','name','auxInfo'{{M[1],M[5],T\"Q\",},{M[1],M[6],T\"Q_T\",},{M[8],M[0],T\"is_active_c2_Regulator_Solver_2016\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 3, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_Regulator_Solver_2016_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_Regulator_Solver_2016InstanceStruct *chartInstance =
      (SFc2_Regulator_Solver_2016InstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _Regulator_Solver_2016MachineNumber_,
           2,
           1,
           1,
           0,
           7,
           0,
           0,
           0,
           0,
           0,
           &chartInstance->chartNumber,
           &chartInstance->instanceNumber,
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation(_Regulator_Solver_2016MachineNumber_,
          chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,_Regulator_Solver_2016MachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _Regulator_Solver_2016MachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"S");
          _SFD_SET_DATA_PROPS(1,1,1,0,"D");
          _SFD_SET_DATA_PROPS(2,1,1,0,"C");
          _SFD_SET_DATA_PROPS(3,1,1,0,"B");
          _SFD_SET_DATA_PROPS(4,1,1,0,"A");
          _SFD_SET_DATA_PROPS(5,2,0,1,"Q_T");
          _SFD_SET_DATA_PROPS(6,2,0,1,"Q");
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
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,165);

        {
          unsigned int dimVector[2];
          dimVector[0]= 2U;
          dimVector[1]= 2U;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_e_sf_marshallOut,(MexInFcnForType)NULL);

        {
          unsigned int dimVector[2];
          dimVector[0]= 1U;
          dimVector[1]= 2U;
          _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_d_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 2U;
          dimVector[1]= 1U;
          _SFD_SET_DATA_COMPILED_PROPS(3,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_c_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 2U;
          dimVector[1]= 2U;
          _SFD_SET_DATA_COMPILED_PROPS(4,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 6U;
          dimVector[1]= 6U;
          _SFD_SET_DATA_COMPILED_PROPS(5,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)
            c2_sf_marshallIn);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 6U;
          dimVector[1]= 6U;
          _SFD_SET_DATA_COMPILED_PROPS(6,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)
            c2_sf_marshallIn);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _Regulator_Solver_2016MachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static void chart_debug_initialize_data_addresses(SimStruct *S)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_Regulator_Solver_2016InstanceStruct *chartInstance =
      (SFc2_Regulator_Solver_2016InstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(5U, *chartInstance->c2_Q_T);
        _SFD_SET_DATA_VALUE_PTR(6U, *chartInstance->c2_Q);
        _SFD_SET_DATA_VALUE_PTR(0U, *chartInstance->c2_S);
        _SFD_SET_DATA_VALUE_PTR(1U, chartInstance->c2_D);
        _SFD_SET_DATA_VALUE_PTR(2U, *chartInstance->c2_C);
        _SFD_SET_DATA_VALUE_PTR(3U, *chartInstance->c2_B);
        _SFD_SET_DATA_VALUE_PTR(4U, *chartInstance->c2_A);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "s65WJFdZWh2mZmxM8l7Jp2D";
}

static void sf_opaque_initialize_c2_Regulator_Solver_2016(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc2_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c2_Regulator_Solver_2016
    ((SFc2_Regulator_Solver_2016InstanceStruct*) chartInstanceVar);
  initialize_c2_Regulator_Solver_2016((SFc2_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c2_Regulator_Solver_2016(void *chartInstanceVar)
{
  enable_c2_Regulator_Solver_2016((SFc2_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_disable_c2_Regulator_Solver_2016(void *chartInstanceVar)
{
  disable_c2_Regulator_Solver_2016((SFc2_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c2_Regulator_Solver_2016(void *chartInstanceVar)
{
  sf_gateway_c2_Regulator_Solver_2016((SFc2_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c2_Regulator_Solver_2016(SimStruct*
  S)
{
  return get_sim_state_c2_Regulator_Solver_2016
    ((SFc2_Regulator_Solver_2016InstanceStruct *)sf_get_chart_instance_ptr(S));/* raw sim ctx */
}

static void sf_opaque_set_sim_state_c2_Regulator_Solver_2016(SimStruct* S, const
  mxArray *st)
{
  set_sim_state_c2_Regulator_Solver_2016
    ((SFc2_Regulator_Solver_2016InstanceStruct*)sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_terminate_c2_Regulator_Solver_2016(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_Regulator_Solver_2016InstanceStruct*) chartInstanceVar)
      ->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Regulator_Solver_2016_optimization_info();
    }

    finalize_c2_Regulator_Solver_2016((SFc2_Regulator_Solver_2016InstanceStruct*)
      chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_Regulator_Solver_2016
    ((SFc2_Regulator_Solver_2016InstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_Regulator_Solver_2016(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_Regulator_Solver_2016
      ((SFc2_Regulator_Solver_2016InstanceStruct*)sf_get_chart_instance_ptr(S));
  }
}

static void mdlSetWorkWidths_c2_Regulator_Solver_2016(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetStatesModifiedOnlyInUpdate(S, 1);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_Regulator_Solver_2016_optimization_info
      (sim_mode_is_rtw_gen(S), sim_mode_is_modelref_sim(S), sim_mode_is_external
       (S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,2,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 2);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,2);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 3, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 4, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,2,5);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,2,2);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=2; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 5; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,2);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(832246261U));
  ssSetChecksum1(S,(1041173395U));
  ssSetChecksum2(S,(1016922009U));
  ssSetChecksum3(S,(2664432373U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c2_Regulator_Solver_2016(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_Regulator_Solver_2016(SimStruct *S)
{
  SFc2_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc2_Regulator_Solver_2016InstanceStruct *)utMalloc(sizeof
    (SFc2_Regulator_Solver_2016InstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc2_Regulator_Solver_2016InstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.mdlStart = mdlStart_c2_Regulator_Solver_2016;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_Regulator_Solver_2016;
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
  mdl_start_c2_Regulator_Solver_2016(chartInstance);
}

void c2_Regulator_Solver_2016_method_dispatcher(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_Regulator_Solver_2016(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_Regulator_Solver_2016(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_Regulator_Solver_2016(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_Regulator_Solver_2016_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
