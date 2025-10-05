
t 0 140.00	/* tempo */

i 90 0 34.0	/* output instrument */

#define Rhytm1(START#NOTE) #

i 1	[$START+0.0000]	0.5	$NOTE	120
i 1	[$START+0.9890]	0.5	$NOTE	112
i 1	[$START+1.9780]	0.5	$NOTE	124
i 1	[$START+2.9780]	0.5	$NOTE	112

i 1	[$START+4.0000]	0.5	$NOTE	120
i 1	[$START+4.9890]	0.5	$NOTE	112
i 1	[$START+5.9780]	0.5	$NOTE	116
i 1	[$START+6.9780]	0.5	$NOTE	120
i 1	[$START+7.5000]	0.5	$NOTE	120

i 1	[$START+8.0000]	0.5	$NOTE	120
i 1	[$START+8.9890]	0.5	$NOTE	112
i 1	[$START+9.9780]	0.5	$NOTE	124
i 1	[$START+10.978]	0.5	$NOTE	112

i 1	[$START+12.000]	0.5	$NOTE	120
i 1	[$START+12.989]	0.5	$NOTE	112
i 1	[$START+13.978]	0.5	$NOTE	116
i 1	[$START+14.978]	0.5	$NOTE	112

#

$Rhytm1(0#33)
$Rhytm1(16#33)

/* ------------------------------------------------------------------------- */

f 64 0 128 -2	10000.0		/* output volume			*/
		140.0		/* tempo				*/

		4.3333		/* oscillator start freq. 1 / note frq.	*/
		8.0		/* osc. frq. 1 decay speed at max. vel.	*/
		16.0		/* osc. freq. 1 max. decay speed	*/
		96		/* note velocity for max. decay speed	*/
		1.0		/* oscillator start freq. 2 / note frq.	*/
		2.0		/* osc. freq. 2 decay speed		*/
		10.6667		/* oscillator start freq. 3 / note frq.	*/
		128.0		/* osc. freq. 3 decay speed		*/
		0.0		/* oscillator start freq. 4 / note frq.	*/
		1.0		/* osc. freq. 4 decay speed		*/

		0		/* lowpass filter start freq. 1 (Hz)	*/
		1		/* lowpass filter freq. 1 decay speed	*/
		0		/* lowpass filter start freq. 2 (Hz)	*/
		1		/* lowpass filter freq. 2 decay speed	*/
		48.0		/* LP filter start freq. 3 / note frq.	*/
		64.0		/* lowpass filter freq. 3 decay speed	*/
		16.0		/* LP filter start freq. 4 / note frq.	*/
		12.0		/* lowpass filter freq. 4 decay speed	*/

		0		/* EQ 1 frequency / osc. frequency	*/
		1.5		/* EQ 1 frequency / note frequency	*/
		0		/* EQ 1 frequency (Hz)			*/
		1.4142		/* EQ 1 level				*/
		1.4142		/* EQ 1 Q				*/
		0		/* EQ 1 mode (0:peak,1:low,2:high)	*/

		0		/* EQ 2 frequency / osc. frequency	*/
		4		/* EQ 2 frequency / note frequency	*/
		0		/* EQ 2 frequency (Hz)			*/
		0.25		/* EQ 2 level				*/
		1.0		/* EQ 2 Q				*/
		2		/* EQ 2 mode (0:peak,1:low,2:high)	*/

		0		/* EQ 3 frequency / osc. frequency	*/
		0		/* EQ 3 frequency / note frequency	*/
		1000		/* EQ 3 frequency (Hz)			*/
		1.0		/* EQ 3 level				*/
		0.7071		/* EQ 3 Q				*/
		0		/* EQ 3 mode (0:peak,1:low,2:high)	*/

		0		/* EQ 4 frequency / osc. frequency	*/
		0		/* EQ 4 frequency / note frequency	*/
		1000		/* EQ 4 frequency (Hz)			*/
		1.0		/* EQ 4 level				*/
		0.7071		/* EQ 4 Q				*/
		0		/* EQ 4 mode (0:peak,1:low,2:high)	*/

		1.0		/* noise mix				*/

		0		/* noise EQ 1 frequency / osc. freq.	*/
		0		/* noise EQ 1 frequency / note freq.	*/
		1000		/* noise EQ 1 frequency (Hz)		*/
		1.0		/* noise EQ 1 level			*/
		0.7071		/* noise EQ 1 Q				*/
		1		/* noise EQ 1 mode (0:peak,1:lo,2:hi)	*/

		0		/* noise EQ 2 frequency / osc. freq.	*/
		0		/* noise EQ 2 frequency / note freq.	*/
		1000		/* noise EQ 2 frequency (Hz)		*/
		1.0		/* noise EQ 2 level			*/
		0.7071		/* noise EQ 2 Q				*/
		0		/* noise EQ 2 mode (0:peak,1:lo,2:hi)	*/

		48	55	/* MIDI key range for panning		*/
		0	0	/* azimuth range			*/
		0	0	/* elevation range			*/
		0.5	0.5	/* distance range			*/

/* ------------------------------------------------------------------------- */

f 1 0 262144 10 1

e	/* end of score */


