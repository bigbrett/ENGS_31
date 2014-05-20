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
static const char *ng0 = "//thayerfs/d36937q/Desktop/Digitaldesign/Lab 3/Lab4/SerialRx_tb13x.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );


static void work_a_2462010086_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 3032U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(69, ng0);
    t2 = (t0 + 3664);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(70, ng0);
    t2 = (t0 + 1808U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 2840);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(71, ng0);
    t2 = (t0 + 3664);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(72, ng0);
    t2 = (t0 + 1808U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 2840);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_2462010086_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    int64 t5;
    char *t6;
    char *t7;
    char *t8;
    int t9;
    int t10;
    int t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned char t22;

LAB0:    t1 = (t0 + 3280U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(78, ng0);
    t3 = (50 * 1000000LL);
    t2 = (t0 + 3088);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(79, ng0);
    t2 = (t0 + 1808U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (10.250000000000000 * t3);
    t2 = (t0 + 3088);
    xsi_process_wait(t2, t5);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(81, ng0);
    t2 = (t0 + 3728);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 1928U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3088);
    xsi_process_wait(t2, t3);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 6172);
    *((int *)t2) = 0;
    t4 = (t0 + 6176);
    *((int *)t4) = 7;
    t9 = 0;
    t10 = 7;

LAB16:    if (t9 <= t10)
        goto LAB17;

LAB19:    xsi_set_current_line(89, ng0);
    t2 = (t0 + 3728);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(90, ng0);
    t3 = (100 * 1000000LL);
    t2 = (t0 + 3088);
    xsi_process_wait(t2, t3);

LAB27:    *((char **)t1) = &&LAB28;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB17:    xsi_set_current_line(85, ng0);
    t6 = (t0 + 2048U);
    t7 = *((char **)t6);
    t6 = (t0 + 6172);
    t11 = *((int *)t6);
    t12 = (t11 - 7);
    t13 = (t12 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, *((int *)t6));
    t14 = (1U * t13);
    t15 = (0 + t14);
    t8 = (t7 + t15);
    t16 = *((unsigned char *)t8);
    t17 = (t0 + 3728);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    *((unsigned char *)t21) = t16;
    xsi_driver_first_trans_fast(t17);
    xsi_set_current_line(86, ng0);
    t2 = (t0 + 1928U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3088);
    xsi_process_wait(t2, t3);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB18:    t2 = (t0 + 6172);
    t9 = *((int *)t2);
    t4 = (t0 + 6176);
    t10 = *((int *)t4);
    if (t9 == t10)
        goto LAB19;

LAB24:    t11 = (t9 + 1);
    t9 = t11;
    t6 = (t0 + 6172);
    *((int *)t6) = t9;
    goto LAB16;

LAB20:    goto LAB18;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB25:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 3728);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(93, ng0);
    t2 = (t0 + 1928U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3088);
    xsi_process_wait(t2, t3);

LAB31:    *((char **)t1) = &&LAB32;
    goto LAB1;

LAB26:    goto LAB25;

LAB28:    goto LAB26;

LAB29:    xsi_set_current_line(95, ng0);
    t2 = (t0 + 6180);
    *((int *)t2) = 0;
    t4 = (t0 + 6184);
    *((int *)t4) = 7;
    t9 = 0;
    t10 = 7;

LAB33:    if (t9 <= t10)
        goto LAB34;

LAB36:    xsi_set_current_line(100, ng0);
    t2 = (t0 + 3728);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(101, ng0);

LAB44:    *((char **)t1) = &&LAB45;
    goto LAB1;

LAB30:    goto LAB29;

LAB32:    goto LAB30;

LAB34:    xsi_set_current_line(96, ng0);
    t6 = (t0 + 2048U);
    t7 = *((char **)t6);
    t6 = (t0 + 6180);
    t11 = *((int *)t6);
    t12 = (t11 - 7);
    t13 = (t12 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, *((int *)t6));
    t14 = (1U * t13);
    t15 = (0 + t14);
    t8 = (t7 + t15);
    t16 = *((unsigned char *)t8);
    t22 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t16);
    t17 = (t0 + 3728);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    *((unsigned char *)t21) = t22;
    xsi_driver_first_trans_fast(t17);
    xsi_set_current_line(97, ng0);
    t2 = (t0 + 1928U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t2 = (t0 + 3088);
    xsi_process_wait(t2, t3);

LAB39:    *((char **)t1) = &&LAB40;
    goto LAB1;

LAB35:    t2 = (t0 + 6180);
    t9 = *((int *)t2);
    t4 = (t0 + 6184);
    t10 = *((int *)t4);
    if (t9 == t10)
        goto LAB36;

LAB41:    t11 = (t9 + 1);
    t9 = t11;
    t6 = (t0 + 6180);
    *((int *)t6) = t9;
    goto LAB33;

LAB37:    goto LAB35;

LAB38:    goto LAB37;

LAB40:    goto LAB38;

LAB42:    goto LAB2;

LAB43:    goto LAB42;

LAB45:    goto LAB43;

}


extern void work_a_2462010086_2372691052_init()
{
	static char *pe[] = {(void *)work_a_2462010086_2372691052_p_0,(void *)work_a_2462010086_2372691052_p_1};
	xsi_register_didat("work_a_2462010086_2372691052", "isim/SerialRx_tb_isim_beh.exe.sim/work/a_2462010086_2372691052.didat");
	xsi_register_executes(pe);
}
