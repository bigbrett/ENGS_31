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
static const char *ng0 = "//thayerfs/d36937q/network_digitaldesign/8-20/freqcalc.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1547198987_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_1547270861_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
char *ieee_p_1242562249_sub_2053728113_1035706684(char *, char *, char *, char *, char *, char *);
unsigned char ieee_p_1242562249_sub_2110339434_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_1242562249_sub_2110375371_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_1242562249_sub_2110411308_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_3752224209_3212880686_p_0(char *t0)
{
    char t8[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned char t14;
    int t15;
    char *t16;

LAB0:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 2312U);
    t3 = *((char **)t1);
    t1 = (t0 + 7908U);
    t4 = (t0 + 8187);
    t6 = (t8 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 0;
    t7 = (t6 + 4U);
    *((int *)t7) = 31;
    t7 = (t6 + 8U);
    *((int *)t7) = 1;
    t15 = (31 - 0);
    t9 = (t15 * 1);
    t9 = (t9 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t9;
    t2 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t3, t1, t4, t8);
    if (t2 != 0)
        goto LAB12;

LAB14:
LAB13:    t1 = (t0 + 4728);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(59, ng0);
    t3 = (t0 + 4840);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(60, ng0);
    t1 = (t0 + 1672U);
    t3 = *((char **)t1);
    t1 = (t0 + 7860U);
    t4 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t8, t3, t1, 1);
    t5 = (t8 + 12U);
    t9 = *((unsigned int *)t5);
    t10 = (1U * t9);
    t2 = (48U != t10);
    if (t2 == 1)
        goto LAB5;

LAB6:    t6 = (t0 + 4904);
    t7 = (t6 + 56U);
    t11 = *((char **)t7);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t4, 48U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(62, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t14 = (t2 <= (unsigned char)3);
    if (t14 != 0)
        goto LAB7;

LAB9:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 2312U);
    t3 = *((char **)t1);
    t1 = (t0 + 7908U);
    t4 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t8, t3, t1, 1);
    t5 = (t8 + 12U);
    t9 = *((unsigned int *)t5);
    t10 = (1U * t9);
    t2 = (32U != t10);
    if (t2 == 1)
        goto LAB10;

LAB11:    t6 = (t0 + 4968);
    t7 = (t6 + 56U);
    t11 = *((char **)t7);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t4, 32U);
    xsi_driver_first_trans_fast(t6);

LAB8:    goto LAB3;

LAB5:    xsi_size_not_matching(48U, t10, 0);
    goto LAB6;

LAB7:    xsi_set_current_line(63, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t4 = t1;
    memset(t4, (unsigned char)2, 32U);
    t5 = (t0 + 4968);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t1, 32U);
    xsi_driver_first_trans_fast(t5);
    goto LAB8;

LAB10:    xsi_size_not_matching(32U, t10, 0);
    goto LAB11;

LAB12:    xsi_set_current_line(70, ng0);
    t7 = (t0 + 4840);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t16 = *((char **)t13);
    *((unsigned char *)t16) = (unsigned char)3;
    xsi_driver_first_trans_fast(t7);
    goto LAB13;

}

static void work_a_3752224209_3212880686_p_1(char *t0)
{
    char t11[16];
    char t21[16];
    char t22[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    int t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    unsigned int t28;

LAB0:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 1152U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4744);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(84, ng0);
    t3 = (t0 + 5032);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(85, ng0);
    t1 = (t0 + 5096);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(87, ng0);
    t1 = (t0 + 2472U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t8 = (t2 == (unsigned char)3);
    if (t8 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 7860U);
    t4 = (t0 + 1672U);
    t5 = *((char **)t4);
    t4 = (t0 + 7860U);
    t2 = ieee_p_1242562249_sub_2110339434_1035706684(IEEE_P_1242562249, t3, t1, t5, t4);
    if (t2 != 0)
        goto LAB8;

LAB9:    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 7860U);
    t4 = (t0 + 1672U);
    t5 = *((char **)t4);
    t4 = (t0 + 7860U);
    t2 = ieee_p_1242562249_sub_2110411308_1035706684(IEEE_P_1242562249, t3, t1, t5, t4);
    if (t2 != 0)
        goto LAB12;

LAB13:    xsi_set_current_line(103, ng0);
    t1 = xsi_get_transient_memory(48U);
    memset(t1, 0, 48U);
    t3 = t1;
    memset(t3, (unsigned char)2, 48U);
    t4 = (t0 + 5160);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    memcpy(t9, t1, 48U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(104, ng0);
    t1 = (t0 + 5096);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB6:    xsi_set_current_line(108, ng0);
    t1 = (t0 + 1672U);
    t3 = *((char **)t1);
    t1 = (t0 + 5288);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 48U);
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(88, ng0);
    t1 = xsi_get_transient_memory(48U);
    memset(t1, 0, 48U);
    t4 = t1;
    memset(t4, (unsigned char)2, 48U);
    t5 = (t0 + 5160);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 48U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(89, ng0);
    t1 = (t0 + 5032);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(90, ng0);
    t1 = (t0 + 5096);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB6;

LAB8:    xsi_set_current_line(93, ng0);
    t6 = (t0 + 1672U);
    t7 = *((char **)t6);
    t6 = (t0 + 7860U);
    t9 = (t0 + 1832U);
    t10 = *((char **)t9);
    t9 = (t0 + 7860U);
    t12 = ieee_p_1242562249_sub_1547270861_1035706684(IEEE_P_1242562249, t11, t7, t6, t10, t9);
    t13 = (t11 + 12U);
    t14 = *((unsigned int *)t13);
    t15 = (1U * t14);
    t8 = (48U != t15);
    if (t8 == 1)
        goto LAB10;

LAB11:    t16 = (t0 + 5160);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t12, 48U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(94, ng0);
    t1 = (t0 + 5096);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB6;

LAB10:    xsi_size_not_matching(48U, t15, 0);
    goto LAB11;

LAB12:    xsi_set_current_line(97, ng0);
    t6 = (t0 + 8219);
    t9 = (t22 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 0;
    t10 = (t9 + 4U);
    *((int *)t10) = 51;
    t10 = (t9 + 8U);
    *((int *)t10) = 1;
    t23 = (51 - 0);
    t14 = (t23 * 1);
    t14 = (t14 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t14;
    t10 = (t0 + 1832U);
    t12 = *((char **)t10);
    t10 = (t0 + 7860U);
    t13 = ieee_p_1242562249_sub_1547270861_1035706684(IEEE_P_1242562249, t21, t6, t22, t12, t10);
    t16 = (t0 + 1672U);
    t17 = *((char **)t16);
    t16 = (t0 + 7860U);
    t18 = ieee_p_1242562249_sub_1547198987_1035706684(IEEE_P_1242562249, t11, t13, t21, t17, t16);
    t19 = (t11 + 12U);
    t14 = *((unsigned int *)t19);
    t15 = (1U * t14);
    t8 = (52U != t15);
    if (t8 == 1)
        goto LAB14;

LAB15:    t20 = (t0 + 5224);
    t24 = (t20 + 56U);
    t25 = *((char **)t24);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    memcpy(t27, t18, 52U);
    xsi_driver_first_trans_fast(t20);
    xsi_set_current_line(98, ng0);
    t1 = (t0 + 2152U);
    t3 = *((char **)t1);
    t14 = (51 - 47);
    t15 = (t14 * 1U);
    t28 = (0 + t15);
    t1 = (t3 + t28);
    t4 = (t0 + 5160);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    memcpy(t9, t1, 48U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(100, ng0);
    t1 = (t0 + 5096);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB6;

LAB14:    xsi_size_not_matching(52U, t15, 0);
    goto LAB15;

}

static void work_a_3752224209_3212880686_p_2(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    xsi_set_current_line(117, ng0);

LAB3:    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t2 = (t0 + 7876U);
    t4 = (t0 + 2928U);
    t5 = *((char **)t4);
    t4 = (t0 + 7924U);
    t6 = ieee_p_1242562249_sub_2053728113_1035706684(IEEE_P_1242562249, t1, t3, t2, t5, t4);
    t7 = (t0 + 5352);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t6, 54U);
    xsi_driver_first_trans_fast_port(t7);

LAB2:    t12 = (t0 + 4760);
    *((int *)t12) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3752224209_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3752224209_3212880686_p_0,(void *)work_a_3752224209_3212880686_p_1,(void *)work_a_3752224209_3212880686_p_2};
	xsi_register_didat("work_a_3752224209_3212880686", "isim/sinwave_tb_isim_beh.exe.sim/work/a_3752224209_3212880686.didat");
	xsi_register_executes(pe);
}
