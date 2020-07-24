/* Include files */

#include "Regulator_Solver_2016_sfun.h"
#include "c1_Regulator_Solver_2016.h"
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
static const char * c1_debug_family_names[5] = { "nargin", "nargout", "E", "F",
  "vec_EF" };

/* Function Declarations */
static void initialize_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void initialize_params_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void enable_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void disable_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void c1_update_debugger_state_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static const mxArray *get_sim_state_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void set_sim_state_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance, const mxArray *c1_st);
static void finalize_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void sf_gateway_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void mdl_start_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void initSimStructsc1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static void c1_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_b_vec_EF, const char_T *c1_identifier,
  real_T c1_y[6]);
static void c1_b_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  real_T c1_y[6]);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static real_T c1_c_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_e_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_d_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint8_T c1_e_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_b_is_active_c1_Regulator_Solver_2016, const
  char_T *c1_identifier);
static uint8_T c1_f_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void init_dsm_address_info(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance);

/* Function Definitions */
static void initialize_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc1_Regulator_Solver_2016(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c1_is_active_c1_Regulator_Solver_2016 = 0U;
}

static void initialize_params_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c1_update_debugger_state_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_y = NULL;
  const mxArray *c1_b_y = NULL;
  uint8_T c1_hoistedGlobal;
  const mxArray *c1_c_y = NULL;
  c1_st = NULL;
  c1_st = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_createcellmatrix(2, 1), false);
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", *chartInstance->c1_vec_EF, 0, 0U, 1U,
    0U, 1, 6), false);
  sf_mex_setcell(c1_y, 0, c1_b_y);
  c1_hoistedGlobal = chartInstance->c1_is_active_c1_Regulator_Solver_2016;
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_hoistedGlobal, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c1_y, 1, c1_c_y);
  sf_mex_assign(&c1_st, c1_y, false);
  return c1_st;
}

static void set_sim_state_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance, const mxArray *c1_st)
{
  const mxArray *c1_u;
  real_T c1_dv0[6];
  int32_T c1_i0;
  chartInstance->c1_doneDoubleBufferReInit = true;
  c1_u = sf_mex_dup(c1_st);
  c1_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell("vec_EF", c1_u, 0)),
                      "vec_EF", c1_dv0);
  for (c1_i0 = 0; c1_i0 < 6; c1_i0++) {
    (*chartInstance->c1_vec_EF)[c1_i0] = c1_dv0[c1_i0];
  }

  chartInstance->c1_is_active_c1_Regulator_Solver_2016 = c1_e_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(
       "is_active_c1_Regulator_Solver_2016", c1_u, 1)),
     "is_active_c1_Regulator_Solver_2016");
  sf_mex_destroy(&c1_u);
  c1_update_debugger_state_c1_Regulator_Solver_2016(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  int32_T c1_i1;
  int32_T c1_i2;
  int32_T c1_i3;
  int32_T c1_i4;
  real_T c1_b_E[4];
  uint32_T c1_debug_family_var_map[5];
  real_T c1_b_F[2];
  real_T c1_nargin = 2.0;
  real_T c1_nargout = 1.0;
  real_T c1_b_vec_EF[6];
  int32_T c1_i5;
  int32_T c1_i6;
  int32_T c1_i7;
  int32_T c1_i8;
  int32_T c1_i9;
  int32_T c1_i10;
  real_T c1_x[6];
  int32_T c1_k;
  int32_T c1_i11;
  int32_T c1_i12;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  for (c1_i1 = 0; c1_i1 < 2; c1_i1++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c1_F)[c1_i1], 1U, 1U, 0U,
                          chartInstance->c1_sfEvent, false);
  }

  for (c1_i2 = 0; c1_i2 < 4; c1_i2++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c1_E)[c1_i2], 0U, 1U, 0U,
                          chartInstance->c1_sfEvent, false);
  }

  chartInstance->c1_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  for (c1_i3 = 0; c1_i3 < 4; c1_i3++) {
    c1_b_E[c1_i3] = (*chartInstance->c1_E)[c1_i3];
  }

  for (c1_i4 = 0; c1_i4 < 2; c1_i4++) {
    c1_b_F[c1_i4] = (*chartInstance->c1_F)[c1_i4];
  }

  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 5U, 5U, c1_debug_family_names,
    c1_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargin, 0U, c1_d_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargout, 1U, c1_d_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_b_E, 2U, c1_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_b_F, 3U, c1_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_b_vec_EF, 4U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 4);
  c1_i5 = 0;
  c1_i6 = 0;
  for (c1_i7 = 0; c1_i7 < 2; c1_i7++) {
    for (c1_i9 = 0; c1_i9 < 2; c1_i9++) {
      c1_x[c1_i9 + c1_i5] = c1_b_E[c1_i9 + c1_i6];
    }

    c1_i5 += 3;
    c1_i6 += 2;
  }

  c1_i8 = 0;
  for (c1_i10 = 0; c1_i10 < 2; c1_i10++) {
    c1_x[c1_i8 + 2] = c1_b_F[c1_i10];
    c1_i8 += 3;
  }

  for (c1_k = 0; c1_k + 1 < 7; c1_k++) {
    c1_b_vec_EF[c1_k] = c1_x[c1_k];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -4);
  _SFD_SYMBOL_SCOPE_POP();
  for (c1_i11 = 0; c1_i11 < 6; c1_i11++) {
    (*chartInstance->c1_vec_EF)[c1_i11] = c1_b_vec_EF[c1_i11];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_Regulator_Solver_2016MachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
  for (c1_i12 = 0; c1_i12 < 6; c1_i12++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c1_vec_EF)[c1_i12], 2U, 1U, 0U,
                          chartInstance->c1_sfEvent, false);
  }
}

static void mdl_start_c1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void initSimStructsc1_Regulator_Solver_2016
  (SFc1_Regulator_Solver_2016InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber)
{
  (void)c1_machineNumber;
  (void)c1_chartNumber;
  (void)c1_instanceNumber;
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_i13;
  const mxArray *c1_y = NULL;
  real_T c1_u[6];
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  for (c1_i13 = 0; c1_i13 < 6; c1_i13++) {
    c1_u[c1_i13] = (*(real_T (*)[6])c1_inData)[c1_i13];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 1, 6), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static void c1_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_b_vec_EF, const char_T *c1_identifier,
  real_T c1_y[6])
{
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_vec_EF), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_b_vec_EF);
}

static void c1_b_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  real_T c1_y[6])
{
  real_T c1_dv1[6];
  int32_T c1_i14;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_dv1, 1, 0, 0U, 1, 0U, 1, 6);
  for (c1_i14 = 0; c1_i14 < 6; c1_i14++) {
    c1_y[c1_i14] = c1_dv1[c1_i14];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_vec_EF;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y[6];
  int32_T c1_i15;
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_b_vec_EF = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_vec_EF), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_b_vec_EF);
  for (c1_i15 = 0; c1_i15 < 6; c1_i15++) {
    (*(real_T (*)[6])c1_outData)[c1_i15] = c1_y[c1_i15];
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_i16;
  const mxArray *c1_y = NULL;
  real_T c1_u[2];
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  for (c1_i16 = 0; c1_i16 < 2; c1_i16++) {
    c1_u[c1_i16] = (*(real_T (*)[2])c1_inData)[c1_i16];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 2, 1, 2), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_i17;
  int32_T c1_i18;
  const mxArray *c1_y = NULL;
  int32_T c1_i19;
  real_T c1_u[4];
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_i17 = 0;
  for (c1_i18 = 0; c1_i18 < 2; c1_i18++) {
    for (c1_i19 = 0; c1_i19 < 2; c1_i19++) {
      c1_u[c1_i19 + c1_i17] = (*(real_T (*)[4])c1_inData)[c1_i19 + c1_i17];
    }

    c1_i17 += 2;
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 2, 2, 2), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  real_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static real_T c1_c_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_y;
  real_T c1_d0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_nargout;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y;
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_nargout = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_y = c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_nargout), &c1_thisId);
  sf_mex_destroy(&c1_nargout);
  *(real_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

const mxArray *sf_c1_Regulator_Solver_2016_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  sf_mex_assign(&c1_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c1_nameCaptureInfo;
}

static const mxArray *c1_e_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static int32_T c1_d_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_y;
  int32_T c1_i20;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i20, 1, 6, 0U, 0, 0U, 0);
  c1_y = c1_i20;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_y;
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_y = c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint8_T c1_e_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_b_is_active_c1_Regulator_Solver_2016, const
  char_T *c1_identifier)
{
  uint8_T c1_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_y = c1_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_Regulator_Solver_2016), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_Regulator_Solver_2016);
  return c1_y;
}

static uint8_T c1_f_emlrt_marshallIn(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_y;
  uint8_T c1_u0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_y = c1_u0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void init_dsm_address_info(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address(SFc1_Regulator_Solver_2016InstanceStruct
  *chartInstance)
{
  chartInstance->c1_E = (real_T (*)[4])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c1_vec_EF = (real_T (*)[6])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c1_F = (real_T (*)[2])ssGetInputPortSignal_wrapper
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

void sf_c1_Regulator_Solver_2016_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3768052155U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(519098522U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2523646865U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(275461250U);
}

mxArray* sf_c1_Regulator_Solver_2016_get_post_codegen_info(void);
mxArray *sf_c1_Regulator_Solver_2016_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("b3GuCwOCJgcwLA5gcEyb0E");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

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
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(2);
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
      pr[0] = (double)(6);
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
      sf_c1_Regulator_Solver_2016_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_Regulator_Solver_2016_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c1_Regulator_Solver_2016_jit_fallback_info(void)
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

mxArray *sf_c1_Regulator_Solver_2016_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c1_Regulator_Solver_2016_get_post_codegen_info(void)
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

static const mxArray *sf_get_sim_state_info_c1_Regulator_Solver_2016(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"vec_EF\",},{M[8],M[0],T\"is_active_c1_Regulator_Solver_2016\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_Regulator_Solver_2016_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_Regulator_Solver_2016InstanceStruct *chartInstance =
      (SFc1_Regulator_Solver_2016InstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _Regulator_Solver_2016MachineNumber_,
           1,
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
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,61);

        {
          unsigned int dimVector[2];
          dimVector[0]= 2U;
          dimVector[1]= 2U;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_c_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 1U;
          dimVector[1]= 2U;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 6U;
          _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)
            c1_sf_marshallIn);
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
    SFc1_Regulator_Solver_2016InstanceStruct *chartInstance =
      (SFc1_Regulator_Solver_2016InstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(0U, *chartInstance->c1_E);
        _SFD_SET_DATA_VALUE_PTR(2U, *chartInstance->c1_vec_EF);
        _SFD_SET_DATA_VALUE_PTR(1U, *chartInstance->c1_F);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "sowSX1wDt7AR5fdZDkijfY";
}

static void sf_opaque_initialize_c1_Regulator_Solver_2016(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc1_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c1_Regulator_Solver_2016
    ((SFc1_Regulator_Solver_2016InstanceStruct*) chartInstanceVar);
  initialize_c1_Regulator_Solver_2016((SFc1_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c1_Regulator_Solver_2016(void *chartInstanceVar)
{
  enable_c1_Regulator_Solver_2016((SFc1_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_disable_c1_Regulator_Solver_2016(void *chartInstanceVar)
{
  disable_c1_Regulator_Solver_2016((SFc1_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c1_Regulator_Solver_2016(void *chartInstanceVar)
{
  sf_gateway_c1_Regulator_Solver_2016((SFc1_Regulator_Solver_2016InstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c1_Regulator_Solver_2016(SimStruct*
  S)
{
  return get_sim_state_c1_Regulator_Solver_2016
    ((SFc1_Regulator_Solver_2016InstanceStruct *)sf_get_chart_instance_ptr(S));/* raw sim ctx */
}

static void sf_opaque_set_sim_state_c1_Regulator_Solver_2016(SimStruct* S, const
  mxArray *st)
{
  set_sim_state_c1_Regulator_Solver_2016
    ((SFc1_Regulator_Solver_2016InstanceStruct*)sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_terminate_c1_Regulator_Solver_2016(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_Regulator_Solver_2016InstanceStruct*) chartInstanceVar)
      ->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Regulator_Solver_2016_optimization_info();
    }

    finalize_c1_Regulator_Solver_2016((SFc1_Regulator_Solver_2016InstanceStruct*)
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
  initSimStructsc1_Regulator_Solver_2016
    ((SFc1_Regulator_Solver_2016InstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_Regulator_Solver_2016(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_Regulator_Solver_2016
      ((SFc1_Regulator_Solver_2016InstanceStruct*)sf_get_chart_instance_ptr(S));
  }
}

static void mdlSetWorkWidths_c1_Regulator_Solver_2016(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetStatesModifiedOnlyInUpdate(S, 1);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_Regulator_Solver_2016_optimization_info
      (sim_mode_is_rtw_gen(S), sim_mode_is_modelref_sim(S), sim_mode_is_external
       (S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,1,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 1);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,1);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,1,2);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,1,1);
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

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(3931764546U));
  ssSetChecksum1(S,(1438852343U));
  ssSetChecksum2(S,(2986650468U));
  ssSetChecksum3(S,(4104737032U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c1_Regulator_Solver_2016(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_Regulator_Solver_2016(SimStruct *S)
{
  SFc1_Regulator_Solver_2016InstanceStruct *chartInstance;
  chartInstance = (SFc1_Regulator_Solver_2016InstanceStruct *)utMalloc(sizeof
    (SFc1_Regulator_Solver_2016InstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc1_Regulator_Solver_2016InstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.mdlStart = mdlStart_c1_Regulator_Solver_2016;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c1_Regulator_Solver_2016;
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
  mdl_start_c1_Regulator_Solver_2016(chartInstance);
}

void c1_Regulator_Solver_2016_method_dispatcher(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_Regulator_Solver_2016(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_Regulator_Solver_2016(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_Regulator_Solver_2016(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_Regulator_Solver_2016_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
