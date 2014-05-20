/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/new821pm/newpoop/sinwave_tb.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;
extern char *IEEE_P_3972351953;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_2110375371_1035706684(char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_2563015576_1035706684(char *, char *, int , int );
unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
double ieee_p_3972351953_sub_1485185913_2984157535(char *, double );


static void work_a_0553639467_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 5152U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(82, ng0);
    t2 = (t0 + 6824);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 3568U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4960);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 6824);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(85, ng0);
    t2 = (t0 + 3568U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4960);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_0553639467_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(88, ng0);

LAB3:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t3);
    t1 = (t0 + 6888);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_fast(t1);

LAB2:    t9 = (t0 + 6712);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0553639467_2372691052_p_2(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(89, ng0);

LAB3:    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t3 = (15 - 15);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t0 + 6952);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t7;
    xsi_driver_first_trans_fast(t8);

LAB2:    t13 = (t0 + 6728);
    *((int *)t13) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0553639467_2372691052_p_3(char *t0)
{
    char t14[16];
    char t15[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    static char *nl0[] = {&&LAB6, &&LAB7};

LAB0:    xsi_set_current_line(95, ng0);
    t1 = (t0 + 3072U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 6744);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(97, ng0);
    t3 = (t0 + 2792U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t3 = (char *)((nl0) + t5);
    goto **((char **)t3);

LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(101, ng0);
    t6 = (t0 + 1832U);
    t7 = *((char **)t6);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)2);
    if (t9 != 0)
        goto LAB9;

LAB11:    xsi_set_current_line(106, ng0);
    t1 = (t0 + 7016);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB10:    goto LAB5;

LAB7:    xsi_set_current_line(110, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t1 = (t0 + 10284U);
    t4 = (t0 + 10464);
    t7 = (t14 + 0U);
    t10 = (t7 + 0U);
    *((int *)t10) = 0;
    t10 = (t7 + 4U);
    *((int *)t10) = 3;
    t10 = (t7 + 8U);
    *((int *)t10) = 1;
    t16 = (3 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t10 = (t7 + 12U);
    *((unsigned int *)t10) = t17;
    t2 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t3, t1, t4, t14);
    if (t2 != 0)
        goto LAB14;

LAB16:    xsi_set_current_line(113, ng0);
    t1 = (t0 + 7016);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(114, ng0);
    t1 = (t0 + 2472U);
    t3 = *((char **)t1);
    t17 = (15 - 14);
    t21 = (t17 * 1U);
    t22 = (0 + t21);
    t1 = (t3 + t22);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t15 + 0U);
    t10 = (t7 + 0U);
    *((int *)t10) = 14;
    t10 = (t7 + 4U);
    *((int *)t10) = 0;
    t10 = (t7 + 8U);
    *((int *)t10) = -1;
    t16 = (0 - 14);
    t23 = (t16 * -1);
    t23 = (t23 + 1);
    t10 = (t7 + 12U);
    *((unsigned int *)t10) = t23;
    t4 = xsi_base_array_concat(t4, t14, t6, (char)97, t1, t15, (char)99, (unsigned char)2, (char)101);
    t23 = (15U + 1U);
    t2 = (16U != t23);
    if (t2 == 1)
        goto LAB17;

LAB18:    t10 = (t0 + 7144);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t18 = *((char **)t13);
    memcpy(t18, t4, 16U);
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(115, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t1 = (t0 + 10284U);
    t4 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t14, t3, t1, 1);
    t6 = (t14 + 12U);
    t17 = *((unsigned int *)t6);
    t21 = (1U * t17);
    t2 = (4U != t21);
    if (t2 == 1)
        goto LAB19;

LAB20:    t7 = (t0 + 7080);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t4, 4U);
    xsi_driver_first_trans_fast(t7);

LAB15:    goto LAB5;

LAB8:    xsi_set_current_line(119, ng0);
    t1 = (t0 + 7016);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB9:    xsi_set_current_line(102, ng0);
    t6 = (t0 + 7016);
    t10 = (t6 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)1;
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(103, ng0);
    t1 = xsi_get_transient_memory(4U);
    memset(t1, 0, 4U);
    t3 = t1;
    memset(t3, (unsigned char)2, 4U);
    t4 = (t0 + 7080);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 4U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(104, ng0);
    t1 = (t0 + 10460);
    t4 = (t0 + 2952U);
    t6 = *((char **)t4);
    t7 = ((IEEE_P_2592010699) + 4024);
    t10 = (t15 + 0U);
    t11 = (t10 + 0U);
    *((int *)t11) = 0;
    t11 = (t10 + 4U);
    *((int *)t11) = 3;
    t11 = (t10 + 8U);
    *((int *)t11) = 1;
    t16 = (3 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t11 = (t10 + 12U);
    *((unsigned int *)t11) = t17;
    t11 = (t0 + 10300U);
    t4 = xsi_base_array_concat(t4, t14, t7, (char)97, t1, t15, (char)97, t6, t11, (char)101);
    t17 = (4U + 12U);
    t2 = (16U != t17);
    if (t2 == 1)
        goto LAB12;

LAB13:    t12 = (t0 + 7144);
    t13 = (t12 + 56U);
    t18 = *((char **)t13);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t4, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB10;

LAB12:    xsi_size_not_matching(16U, t17, 0);
    goto LAB13;

LAB14:    xsi_set_current_line(111, ng0);
    t10 = (t0 + 7016);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t18 = *((char **)t13);
    *((unsigned char *)t18) = (unsigned char)0;
    xsi_driver_first_trans_fast(t10);
    goto LAB15;

LAB17:    xsi_size_not_matching(16U, t23, 0);
    goto LAB18;

LAB19:    xsi_size_not_matching(4U, t21, 0);
    goto LAB20;

}

static void work_a_0553639467_2372691052_p_4(char *t0)
{
    char t3[16];
    char *t1;
    char *t2;
    char *t4;
    double t5;
    char *t6;
    double t7;
    char *t8;
    double t9;
    double t10;
    char *t11;
    double t12;
    double t13;
    double t14;
    double t15;
    char *t16;
    double t17;
    double t18;
    int t19;
    unsigned char t20;
    unsigned char t21;
    double t22;
    double t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int64 t29;
    int64 t30;

LAB0:    t1 = (t0 + 6144U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(130, ng0);

LAB4:
LAB5:    xsi_set_current_line(131, ng0);
    t2 = (t0 + 3928U);
    t4 = *((char **)t2);
    t5 = *((double *)t4);
    t2 = ((IEEE_P_3972351953) + 1528U);
    t6 = *((char **)t2);
    t7 = *((double *)t6);
    t2 = (t0 + 3808U);
    t8 = *((char **)t2);
    t9 = *((double *)t8);
    t10 = (t7 * t9);
    t2 = (t0 + 4168U);
    t11 = *((char **)t2);
    t12 = *((double *)t11);
    t13 = (t10 * t12);
    t14 = ieee_p_3972351953_sub_1485185913_2984157535(IEEE_P_3972351953, t13);
    t15 = (t5 * t14);
    t2 = (t0 + 3272U);
    t16 = *((char **)t2);
    t17 = *((double *)t16);
    t18 = (t15 + t17);
    t20 = (t18 >= 0);
    if (t20 == 1)
        goto LAB8;

LAB9:    t23 = (t18 - 0.50000000000000000);
    t19 = ((int)(t23));

LAB10:    t2 = ieee_p_1242562249_sub_2563015576_1035706684(IEEE_P_1242562249, t3, t19, 12);
    t24 = (t0 + 7208);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t2, 12U);
    xsi_driver_first_trans_fast(t24);
    xsi_set_current_line(134, ng0);
    t2 = (t0 + 4048U);
    t4 = *((char **)t2);
    t5 = *((double *)t4);
    t7 = xsi_vhdl_pow_double(10.000000000000000, 9);
    t9 = (t5 * t7);
    t20 = (t9 >= 0);
    if (t20 == 1)
        goto LAB16;

LAB17:    t12 = (t9 - 0.50000000000000000);
    t19 = ((int)(t12));

LAB18:    t29 = (1 * 1000LL);
    t30 = (t19 * t29);
    t2 = (t0 + 5952);
    xsi_process_wait(t2, t30);

LAB15:    *((char **)t1) = &&LAB21;

LAB1:    return;
LAB6:;
LAB7:    goto LAB2;

LAB8:    t21 = (t18 >= 2147483647);
    if (t21 == 1)
        goto LAB11;

LAB12:    t22 = (t18 + 0.50000000000000000);
    t19 = ((int)(t22));
    goto LAB10;

LAB11:    t19 = 2147483647;
    goto LAB10;

LAB13:    xsi_set_current_line(135, ng0);
    t2 = (t0 + 4168U);
    t4 = *((char **)t2);
    t5 = *((double *)t4);
    t2 = (t0 + 4048U);
    t6 = *((char **)t2);
    t7 = *((double *)t6);
    t9 = (t5 + t7);
    t2 = (t0 + 4168U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((double *)t2) = t9;
    goto LAB4;

LAB14:    goto LAB13;

LAB16:    t21 = (t9 >= 2147483647);
    if (t21 == 1)
        goto LAB19;

LAB20:    t10 = (t9 + 0.50000000000000000);
    t19 = ((int)(t10));
    goto LAB18;

LAB19:    t19 = 2147483647;
    goto LAB18;

LAB21:    goto LAB14;

}

static void work_a_0553639467_2372691052_p_5(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    t1 = (t0 + 6392U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(148, ng0);
    t3 = (20 * 1000000LL);
    t2 = (t0 + 6200);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(149, ng0);
    t2 = (t0 + 7272);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(151, ng0);
    t3 = (10 * 1000000LL);
    t2 = (t0 + 6200);
    xsi_process_wait(t2, t3);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(152, ng0);
    t2 = (t0 + 10468);
    t5 = (t0 + 7336);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 6U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(154, ng0);
    t3 = (100 * 1000000LL);
    t2 = (t0 + 6200);
    xsi_process_wait(t2, t3);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(159, ng0);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    goto LAB2;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

}


extern void work_a_0553639467_2372691052_init()
{
	static char *pe[] = {(void *)work_a_0553639467_2372691052_p_0,(void *)work_a_0553639467_2372691052_p_1,(void *)work_a_0553639467_2372691052_p_2,(void *)work_a_0553639467_2372691052_p_3,(void *)work_a_0553639467_2372691052_p_4,(void *)work_a_0553639467_2372691052_p_5};
	xsi_register_didat("work_a_0553639467_2372691052", "isim/sinwave_tb_isim_beh.exe.sim/work/a_0553639467_2372691052.didat");
	xsi_register_executes(pe);
}
