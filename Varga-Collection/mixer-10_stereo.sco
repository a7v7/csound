
/* score file for mixer v1.2 */

t 0.00	134.00		/* tempo */

/* p1	=  instrument number (1)		*/
/* p2	=  start time in beats			*/
/* p3	=  duration in beats (ignored)		*/
/* p4	=  track number = (ftable number) - 100	*/
/* p5	=  volume				*/
/* p6	=  part number				*/

;include "part-1.sco"
;include "part-2.sco"
;include "part-3.sco"
#include "part-4.sco"
#include "part-5.sco"

#include "part-10.sco"

;PART01(   0)
;PART02(  64)
;PART03( 128)
$PART04(   0)
$PART05(  64)
;PART05( 224)

;PART10(   0)

/* ------------------------------------------------------------------------- */

f 1 0 16 -2	1.0		/* volume				*/
		62.0		/* output file length in seconds	*/
		1.0		/* output file delay in seconds		*/
		0		/* 0/1 : disable/enable EQ		*/
		1000		/* EQ 1 frequency			*/
		1.0		/* EQ 1 level				*/
		0.7071		/* EQ 1 Q				*/
		0		/* EQ 1 mode (0/1/2 : peak/low/high)	*/
		1000		/* EQ 2 frequency			*/
		1.0		/* EQ 2 level				*/
		0.7071		/* EQ 2 Q				*/
		0		/* EQ 2 mode (0/1/2 : peak/low/high)	*/

/* ------------------------------------------------------------------------- */

/* tnum: table number		*/
/* vol:  volume			*/
/* del:  delay offset		*/
/* fnum: file number list	*/

#define TABLE1(tnum'vol'del'fnum) #

f $tnum 0 32 -2	$vol		/* volume				*/
		0.0		/* skip time in seconds			*/
		$del		/* delay offset in seconds		*/
		0		/* 0/1 : disable/enable EQ		*/
		1000	1.0	/* EQ 1 frequency, level		*/
		0.7071	0	/* EQ 1 Q, mode				*/
		1000	1.0	/* EQ 2 frequency, level		*/
		0.7071	0	/* EQ 2 Q, mode				*/
		$fnum		/* list of file numbers (max. 20)	*/

#

/* drum_06, drum_06_1 .. drum_06_6 */

$TABLE1(100'2.52'0.02'0 1 2 3 4 5 40)

/* organ1 */

$TABLE1(101'1.05'0.025'6 25)

/* bass_0301 */

$TABLE1(102'1.68'0.03'7 22 24)

/* synth_12_1 */

$TABLE1(103'0.84'0.05'8)

/* crash_1 .. crash_6 */

$TABLE1(104'0.42'0.025'9 10 11 12 13 14)

/* ohh_10, ohh_11 */

$TABLE1(105'0.504'0.025'15 16)

/* chh_10, chh_11 */

$TABLE1(106'0.3528'0.025'17 18)

/* tamb_1, tamb_2 */

$TABLE1(107'0.588'0.025'19 20)

/* clap_1 */

$TABLE1(108'2.1'0.025'21)

/* ohh2_10 */

$TABLE1(109'1.05'0.025'23)

/* hit1_1 .. hit1_4 */

$TABLE1(110'2.8'0.032'26 27 28 29)

/* aaah1 */

$TABLE1(111'0.084'0.022'30 41)

/* bsln1 */

$TABLE1(112'1.68'0.02'31)

/* revcym */

$TABLE1(113'0.42'0.025'32 33 34 35)

/* snare */

$TABLE1(114'0.504'0.025'36 37 38 39)

/* aaah2_1 */

$TABLE1(115'0.126'0.025'42)

/* bsln2 */

$TABLE1(116'3.36'0.022'43)

/* ------------------------------------------------------------------------- */

i 90	0.000	1.0	/* output instr. */

e	/* END OF SCORE */


