
t 0.00	150.000		/* tempo	*/

#define rhytm1(STIME) #

i 1	[$STIME+0.0000]		0.4375	31	120
i 1	[$STIME+1.0200]		0.4375	31	116
i 1	[$STIME+2.0100]		0.4375	31	124
i 1	[$STIME+3.0000]		0.4375	31	116

i 1	[$STIME+4.0000]		0.4375	31	118
i 1	[$STIME+4.9900]		0.4375	31	116
i 1	[$STIME+5.9800]		0.4375	31	114
i 1	[$STIME+6.9700]		0.4375	31	112

#

$rhytm1(0)
$rhytm1(8)

/* ------------------------------------------------------------------------- */

f 64 0 32 -2	1.5		/* volume				*/
		150		/* tempo				*/

		0.1667		/* release time (sec.)			*/
		0.01		/* delay time				*/
		0.0		/* random mod. of delay (sec.)		*/
		0.0		/* rnd. mod. of velocity		*/

		5.3333		/* oscillator start frequency (rel.)	*/
		14.0		/* frequency envelope decay speed	*/
		0.5		/* OSC1 BP bandwidth (rel.)		*/
		0.0625		/* OSC1 HP frequency (rel.)		*/
		2.0		/* OSC1 allp. filter start freq. (rel.)	*/
		0.0625		/* OSC1 allpass filter end freq.	*/
		8		/* OSC1 allpass filter envelope speed	*/
		8		/* OSC2 HP1 frequency (rel.)		*/
		-3		/* OSC2 HP1 mix				*/
		0.5		/* OSC2 output HP frq. (rel.)		*/
		0.4		/* OSC2 output gain			*/
		1.0		/* output HP frq. (rel. to note f.)	*/
		2.0		/* output HP resonance			*/
		24		/* output LP start freq. 1 (rel.)	*/
		16		/* output LP freq. env. 1 decay speed	*/
		8		/* output LP start freq. 2		*/
		8		/* output LP freq. env. 2 decay speed	*/

		7040		/* noise BP start frequency (Hz)	*/
		7040		/* noise BP end frequency		*/
		2		/* noise BP bandwidth/freq.		*/
		3520		/* noise LP start frequency (Hz)	*/
		55		/* noise LP end frequency		*/
		12		/* noise filter envelope speed		*/
		0.01		/* noise attack time (sec.)		*/
		3		/* noise decay speed			*/
		0.15		/* noise mix				*/

/*-------------------------------------------------------------------------- */

f 256 0 262144 10 1

e	/* end of score */


