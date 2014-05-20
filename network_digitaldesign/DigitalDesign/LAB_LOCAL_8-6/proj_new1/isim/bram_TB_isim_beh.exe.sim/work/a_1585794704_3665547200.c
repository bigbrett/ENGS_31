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
static const char *ng0 = "C:/Users/d36937q/Desktop/LAB_LOCAL_8-6/finallab/debounce.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_2507238156_503743352(char *, unsigned char , unsigned char );
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );


static void work_a_1585794704_3665547200_p_0(char *t0)
{
    char t13[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned char t11;
    char *t12;
    char *t14;
    unsigned int t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    unsigned int t24;

LAB0:    xsi_set_current_line(23, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(26, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t7 = (0 - 1);
    t8 = (t7 * -1);
    t9 = (1U * t8);
    t10 = (0 + t9);
    t1 = (t3 + t10);
    t2 = *((unsigned char *)t1);
    t4 = (t0 + 1512U);
    t6 = *((char **)t4);
    t22 = (1 - 1);
    t15 = (t22 * -1);
    t23 = (1U * t15);
    t24 = (0 + t23);
    t4 = (t6 + t24);
    t5 = *((unsigned char *)t4);
    t11 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t2, t5);
    t12 = (t0 + 3840);
    t14 = (t12 + 56U);
    t17 = *((char **)t14);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = t11;
    xsi_driver_first_trans_fast(t12);
    t1 = (t0 + 3680);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(24, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t3 = (t0 + 1512U);
    t6 = *((char **)t3);
    t7 = (1 - 1);
    t8 = (t7 * -1);
    t9 = (1U * t8);
    t10 = (0 + t9);
    t3 = (t6 + t10);
    t11 = *((unsigned char *)t3);
    t14 = ((IEEE_P_2592010699) + 4024);
    t12 = xsi_base_array_concat(t12, t13, t14, (char)99, t5, (char)99, t11, (char)101);
    t15 = (1U + 1U);
    t16 = (2U != t15);
    if (t16 == 1)
        goto LAB5;

LAB6:    t17 = (t0 + 3776);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t12, 2U);
    xsi_driver_first_trans_fast(t17);
    goto LAB3;

LAB5:    xsi_size_not_matching(2U, t15, 0);
    goto LAB6;

}

static void work_a_1585794704_3665547200_p_1(char *t0)
{
    char t17[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(33, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3696);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(34, ng0);
    t3 = (t0 + 1672U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t13 = (5 - 18);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t2 = *((unsigned char *)t1);
    t5 = (t2 == (unsigned char)2);
    if (t5 != 0)
        goto LAB8;

LAB9:    xsi_set_current_line(40, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t13 = (1 - 1);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t3 + t16);
    t2 = *((unsigned char *)t1);
    t4 = (t0 + 3968);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t2;
    xsi_driver_first_trans_fast_port(t4);

LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(35, ng0);
    t3 = xsi_get_transient_memory(19U);
    memset(t3, 0, 19U);
    t7 = t3;
    memset(t7, (unsigned char)2, 19U);
    t8 = (t0 + 3904);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t3, 19U);
    xsi_driver_first_trans_fast(t8);
    goto LAB6;

LAB8:    xsi_set_current_line(38, ng0);
    t4 = (t0 + 1832U);
    t7 = *((char **)t4);
    t4 = (t0 + 6040U);
    t8 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t17, t7, t4, 1);
    t9 = (t17 + 12U);
    t18 = *((unsigned int *)t9);
    t19 = (1U * t18);
    t6 = (19U != t19);
    if (t6 == 1)
        goto LAB10;

LAB11:    t10 = (t0 + 3904);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t20 = (t12 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 19U);
    xsi_driver_first_trans_fast(t10);
    goto LAB6;

LAB10:    xsi_size_not_matching(19U, t19, 0);
    goto LAB11;

}


extern void work_a_1585794704_3665547200_init()
{
	static char *pe[] = {(void *)work_a_1585794704_3665547200_p_0,(void *)work_a_1585794704_3665547200_p_1};
	xsi_register_didat("work_a_1585794704_3665547200", "isim/bram_TB_isim_beh.exe.sim/work/a_1585794704_3665547200.didat");
	xsi_register_executes(pe);
}
